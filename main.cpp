#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <chrono>
#include "json.hpp"
#include "fooditem.h"

void to_json(nlohmann::json& j, const FoodItem& item)
{
    j = nlohmann::json{{"food_name", item.food_name}, {"upc", item.upc}, {"time", item.time}};
}

void from_json(const nlohmann::json& j, FoodItem& item)
{
    j.at("food_name").get_to(item.food_name);
    j.at("upc").get_to(item.upc);
    j.at("time").get_to(item.time);
}

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
