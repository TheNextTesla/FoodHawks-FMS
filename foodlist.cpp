#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

#include "foodlist.h"
#include "json.hpp"
#include "json_helper.h"
#include "sqlite3.h"
#include "sqlite3_helper.h"

FoodList::FoodList(QObject *parent) : QObject(parent)
{

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

/*
QString findItemNameByUPC(QString upc)
{
    std::string code = upc.toUtf8().constData();

    //TODO: A


}
*/

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

QList<QString> FoodList::getFoodItemColors()
{
    std::vector<FoodItem> items_temp = items;
    QList<QString> items_return;
    items_return.reserve((int) items_temp.size());

    for(unsigned int i = 0; i < items_temp.size(); i++)
    {
        //TODO: Replace With Food Decision Making Method
        items_return.push_back(QString::fromStdString("Blue"));
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

        return true;
    }
    else
    {
        jsonFile.close();
        return false;
    }
}

bool FoodList::saveOutList()
{
    nlohmann::json jsonObject;
    jsonObject["items"] = this->items;
    jsonObject["waste"] = this->waste;

    std::ofstream jsonFile("/home/pi/fms.json");
    if(jsonFile.is_open())
    {
        jsonFile << jsonObject;
        jsonFile.close();
        return true;
    }
    return false;
}
