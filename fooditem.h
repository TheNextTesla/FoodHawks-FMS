#ifndef FOODITEM_H
#define FOODITEM_H

#include <QObject>
#include <chrono>

class FoodItem : public QObject
{
    Q_OBJECT
public:
    explicit FoodItem(QObject *parent = nullptr);



signals:


public slots:


public:
    std::string food_name;
    std::string upc;
    std::time_t time;

};

#endif // FOODITEM_H
