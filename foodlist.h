#ifndef FOODLIST_H
#define FOODLIST_H

#include <QObject>
#include <QDate>
#include <QList>

#include "fooditem.h"

class FoodList : public QObject
{
    Q_OBJECT
public:
    explicit FoodList(QObject *parent = nullptr);
    bool loadInList();
    bool saveOutList();

signals:

public slots:
    void addItem(QString name, QString upc, QDate date);
    bool removeItem(QString name, QString date, float amount);
    //QString findItemNameByUPC(QString upc);
    QList<QString> getFoodItemsContaining(QString name);
    QList<QString> getFoodItemNames();
    QList<QString> getFoodItemColors();

public:
    std::vector<FoodItem> items;
    std::map<std::string, int> waste;
};

#endif // FOODLIST_H
