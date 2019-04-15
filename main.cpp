#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <chrono>
#include <stdlib.h>
#include <QDebug>
#include "foodlist.h"

static FoodList * foodlist = nullptr;

void on_exit()
{
    qDebug() << "Shutting Down";
    if(foodlist != nullptr)
        foodlist->saveDatabase();
}

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    atexit(on_exit);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qDebug() << "Creating FoodList Object";
    foodlist = new FoodList;

    qDebug() << "Loading JSON List";
    foodlist->loadInList();

    qDebug() << "Loading SQL Database";
    foodlist->loadDatabase();

    qDebug() << "Injecting to Root Context";
    engine.rootContext()->setContextProperty("foodList", foodlist);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
