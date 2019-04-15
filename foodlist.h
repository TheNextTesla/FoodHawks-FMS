#ifndef FOODLIST_H
#define FOODLIST_H

#include <QObject>
#include <QDate>
#include <QList>

#include "fooditem.h"
#include "sqlite3.h"

class FoodList : public QObject
{
    Q_OBJECT
public:
    explicit FoodList(QObject *parent = nullptr);
    bool loadInList();
    bool saveOutList();
    bool loadDatabase();
    bool saveDatabase();

signals:

public slots:
    //Item Management Methods
    void addItem(QString name, QString upc, QDate date);
    bool removeItem(QString name, QString date, float amount);

    //User Management Methods
    void addUser(QString user_code);
    void sendMessage(QString message_contents);
    bool removeAllUsers();

    //Database Management Methods
    void addNewDatabaseEntry(QString upc, QString name, QString company,
                             QString food_group, QString extension_range);
    QString findItemNameByUPC(QString upc);
    QList<QString> getFoodItemColors();

    //Access Methods
    QList<QString> getFoodItemsContaining(QString name);   
    QList<QString> getFoodItemNames();

public:
    std::vector<FoodItem> items;
    std::map<std::string, int> waste;
    std::vector<std::string> users;
    sqlite3* database;
};

#endif // FOODLIST_H
