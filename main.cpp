#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <chrono>
#include "foodlist.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    FoodList * foodlist = new FoodList;
    foodlist->loadInList();
    engine.rootContext()->setContextProperty("foodList", foodlist);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
