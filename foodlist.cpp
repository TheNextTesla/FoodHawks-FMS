#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <QDebug>

#include "foodlist.h"
#include "json.hpp"
#include "json_helper.h"
#include "sqlite3.h"
#include "sqlite3_helper.h"

FoodList::FoodList(QObject *parent) : QObject(parent)
{
    database = nullptr;
}

void FoodList::addItem(QString name, QString upc, QDate date)
{
    items.emplace_back(name.toUtf8().constData(), upc.toUtf8().constData(),
                       date.toString().toUtf8().constData());
    saveOutList();
}

bool FoodList::removeItem(QString name, QString date, float amount)
{
    std::string name_t = name.toUtf8().constData();
    std::string date_t = date.toUtf8().constData();

    std::vector<FoodItem>::iterator itr = items.begin();
    while(itr != items.end())
    {
        if(itr->food_name == name_t && itr->time == date_t)
        {
            waste[name_t] += (int) round(amount * 10);
            items.erase(itr);
            this->saveOutList();
            return true;
        }
        itr++;
    }
    return false;
}

bool FoodList::renameItem(QString old_name, QString new_name)
{
    std::string oldn = old_name.toUtf8().constData();
    std::string newn = new_name.toUtf8().constData();
    for(unsigned int i = 0; i < items.size(); i++)
    {
        if(items[i].food_name == oldn)
        {
            items[i].rename(newn);
            saveOutList();
            return true;
        }
    }
    return false;
}

void FoodList::addUser(QString user_code)
{
    std::string user_code_std = user_code.toUtf8().constData();
    users.push_back(user_code_std);
    saveOutList();
}

void FoodList::sendMessage(QString message_contents)
{
    if(users.size() == 0)
        return;
    std::string command = "curl -s --form-string \"token=a986bnsrqx3hsip8sd2xdp3tzf9fd6\" --form-string \"user=";
    for(unsigned int i = 0; i < users.size(); i++)
    {
        command += users[i];
        if(i != 0 && i < users.size() - 1)
            command += ",";
    }
    command += "\" --form-string \"message=";
    command += message_contents.toUtf8().constData();
    command += "\" --form-string \"html=1\" https://api.pushover.net/1/messages.json";
    qDebug() << "Command Executing " << QString::fromStdString(command);
    system(command.c_str());
}

bool FoodList::removeAllUsers()
{
    if(users.size() == 0)
        return false;
    users.clear();
    saveOutList();
    return true;
}

void FoodList::addNewDatabaseEntry(QString upc, QString name, QString company,
                         QString food_group, QString extension_range)
{
    std::string upc_str = upc.toUtf8().constData();
    std::string name_str = name.toUtf8().constData();
    std::string company_str = company.toUtf8().constData();
    std::string food_group_str = food_group.toUtf8().constData();
    std::string extension_range_str = extension_range.toUtf8().constData();

    std::string request = "INSERT INTO FoodDB VALUES(";
    request += "\"" + upc_str + "\",";
    request += "\"" + name_str + "\",";
    request += "\"" + company_str + "\",";
    request += "\"" + food_group_str + "\",";
    request += "\"" + extension_range_str + "\",";
    request += "\"" + extension_range_str + "\",";
    request += std::string("\"\"") + ");";

    int rc = sqlite3_exec(database, request.c_str(), nullptr, nullptr, nullptr);

    if(rc != SQLITE_OK)
        qDebug() << "SQLITE Command Failed: " + QString::fromStdString(request);
}

QString FoodList::findItemNameByUPC(QString upc)
{
    std::string code = upc.toUtf8().constData();
    std::string request = "SELECT NAME FROM FoodDB WHERE UPC=\"";
    request += code;
    request += "\";";

    std::vector<std::string> return_vals;
    int rc = sqlite3_exec(database, request.c_str(), find_item_callback,
                          &return_vals, nullptr);

    if(rc == SQLITE_OK && return_vals.size() > 0)
    {
        return QString::fromStdString(return_vals[0]);
    }
    else
    {
        qDebug() << "SQLITE Command Failed: " + QString::fromStdString(request);
        if(return_vals.size() > 0)
            qDebug() << ": Function Retuned: " + QString::fromStdString(return_vals[0]);
    }

    return QString::fromStdString("");
}

QList<QString> FoodList::getFoodItemColors()
{
    qDebug() << "Get Item Colors";
    std::vector<FoodItem> items_temp = items;
    QList<QString> items_return;
    items_return.reserve((int) items_temp.size());
    std::vector<std::string> return_vals;

    for(unsigned int i = 0; i < items_temp.size(); i++)
    {
        return_vals.clear();
        std::string request = "SELECT EXTENSIONRANGE FROM FoodDB WHERE NAME=\"";
        request += items_temp[i].food_name;
        request += "\";";

        if(request == "")
        {
            items_return.push_back(QString::fromStdString("Blue"));
            continue;
        }

        int rc = sqlite3_exec(database, request.c_str(), find_item_callback,
                              &return_vals, nullptr);

        if(rc == SQLITE_OK && return_vals.size() > 0)
        {
            qDebug() << "Current Return Value " + QString::fromStdString(return_vals[0]);
            std::size_t find_delim = return_vals[0].find(",");
            int first = std::stoi(return_vals[0].substr(0, find_delim));
            int second = std::stoi(return_vals[0].substr(find_delim + 1, return_vals[0].size()));
            QDate item_date = QDate::fromString(QString::fromStdString(items_temp[i].time));
            int days = item_date.daysTo(QDate::currentDate());
            //qDebug() << QString::fromStdString("There are " + std::to_string(days) + " days until this goes bad");
            if(days < first)
                items_return.push_back(QString::fromStdString("Green"));
            else if(days < second)
                items_return.push_back(QString::fromStdString("Yellow"));
            else
                items_return.push_back(QString::fromStdString("Red"));
        }
        else
        {
            qDebug() << "SQLITE Command Failed: " + QString::fromStdString(request);
            if(return_vals.size() > 0)
                qDebug() << ": Function Retuned: " + QString::fromStdString(return_vals[0]);
            items_return.push_back(QString::fromStdString("Blue"));
        }
    }
    //qDebug() << "Get Item Colors End";
    return items_return;
}


QList<QString> FoodList::getFoodItemNames()
{
    std::vector<FoodItem> items_temp = items;
    QList<QString> items_return;

    for(unsigned int i = 0; i < items_temp.size(); i++)
    {
        items_return.push_back(QString::fromStdString(items_temp[i].food_name));
    }
    return items_return;
}

QList<QString> FoodList::getRemovedFoodItems()
{
    qDebug() << "Getting Removed Food Items";
    std::map<std::string, int>::const_iterator itr = waste.begin();
    QList<QString> return_vals;
    while(itr != waste.end())
    {
        return_vals.push_back(QString::fromStdString(itr->first));
        itr++;
    }
    //qDebug() << "Done Getting Removed Food Items";
    return return_vals;
}

QList<qreal> FoodList::getRemovedFoodWaste()
{
    qDebug() << "Getting Removed Food Waste";
    std::map<std::string, int>::const_iterator itr = waste.begin();
    QList<qreal> return_vals;

    std::vector<int> temp_vals;
    unsigned int sum = 0;
    while(itr != waste.end())
    {
        temp_vals.push_back(itr->second);
        sum += itr->second;
        itr++;
    }

    for(unsigned int i = 0; i < temp_vals.size(); i++)
    {
        return_vals.push_back(100.0 * temp_vals[i] / sum);
    }

    //qDebug() << "Done Getting Removed Food Waste";
    return return_vals;
}

QList<QString> FoodList::getFoodItemsContaining(QString name)
{
    std::string name_t = name.toUtf8().constData();
    std::transform(name_t.begin(), name_t.end(), name_t.begin(), ::tolower);

    QList<QString> items_return;
    std::vector<FoodItem>::iterator itr = items.begin();
    while(itr != items.end())
    {
        std::string food_name_temp = itr->food_name;
        std::transform(food_name_temp.begin(), food_name_temp.end(), food_name_temp.begin(), ::tolower);
        std::size_t pos = food_name_temp.find(name_t);
        if(pos != std::string::npos)
        {
            items_return.push_back(QString::fromStdString(itr->food_name + " | " + itr->time));
        }
        itr++;
    }
    return items_return;
}

bool FoodList::loadInList()
{
    std::ifstream jsonFile("/home/pi/fms.json");
    if(jsonFile.is_open())
    {
        nlohmann::json jsonObject;
        jsonFile >> jsonObject;
        jsonFile.close();

        items.clear();
        jsonObject.at("items").get_to(this->items);
        jsonObject.at("waste").get_to(this->waste);
        jsonObject.at("users").get_to(this->users);

        return true;
    }
    else
    {
        qDebug() << "JSON File Failed to Load";
        jsonFile.close();
        return false;
    }
}

bool FoodList::saveOutList()
{
    nlohmann::json jsonObject;
    jsonObject["items"] = this->items;
    jsonObject["waste"] = this->waste;
    jsonObject["users"] = this->users;

    std::ofstream jsonFile("/home/pi/fms.json");
    if(jsonFile.is_open())
    {
        jsonFile << jsonObject;
        jsonFile.close();
        return true;
    }
    qDebug() << "JSON File Failed to Save";
    return false;
}

bool FoodList::loadDatabase()
{
    sqlite3* db = nullptr;
    int exit = sqlite3_open("/home/pi/database.db", &db);
    if(exit == SQLITE_OK && db != nullptr)
    {
        database = db;
        return true;
    }
    qDebug() << "SQL Database Loading Failed";
    if(db != nullptr)
        sqlite3_close(db);
    return false;
}

bool FoodList::saveDatabase()
{
    if(database == nullptr)
        return false;

    int exit = sqlite3_close(database);
    if(exit == SQLITE_OK)
        return true;
    qDebug() << "SQL Database Saving Failed";
    return false;
}
