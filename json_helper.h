#ifndef JSON_HELPER_H
#define JSON_HELPER_H

#include <string>

#include "json.hpp"
#include "fooditem.h"
#include "foodlist.h"

void to_json(nlohmann::json & j, const FoodItem & item)
{
    j = nlohmann::json{{"food_name", item.food_name}, {"upc", item.upc}, {"time", item.time}};
}

void from_json(const nlohmann::json & j, FoodItem & item)
{
    j.at("food_name").get_to(item.food_name);
    j.at("upc").get_to(item.upc);
    j.at("time").get_to(item.time);
}

#endif // JSON_HELPER_H
