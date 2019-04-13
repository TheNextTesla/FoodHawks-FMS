#ifndef FOODITEM_H
#define FOODITEM_H

#include <string>

class FoodItem
{
public:
    std::string food_name;
    std::string upc;
    std::string time;

public:
    FoodItem();
    FoodItem(const std::string & food_name, const std::string & upc, const std::string time);
};

#endif // FOODITEM_H
