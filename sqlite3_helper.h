#ifndef SQLITE3_HELPER_H
#define SQLITE3_HELPER_H

#include <string>
#include <vector>

#include "sqlite3.h"

int find_item_callback(void* data, int argc, char** argv, char** azColName)
{
    std::vector<std::string> * list = (std::vector<std::string> *) data;
    list->push_back(std::string(argv[0]));
    return 0;
}

#endif // SQLITE3_HELPER_H
