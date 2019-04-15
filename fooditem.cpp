#include "fooditem.h"

FoodItem::FoodItem()
{

}

FoodItem::FoodItem(const std::string & food_name, const std::string & upc, const std::string time)
{
    this->food_name = food_name;
    this->upc = upc;
    this->time = time;
}

void FoodItem::rename(const std::string & new_name)
{
    this->food_name = new_name;
}
