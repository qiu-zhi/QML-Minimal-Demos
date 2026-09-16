#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "itemmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // 注册C++类型到QML
    qmlRegisterType<ItemModel>("ItemModel", 1, 0, "ItemModel");

    // 创建模型实例并设置到上下文
    ItemModel itemModel;
    engine.rootContext()->setContextProperty("itemModel", &itemModel);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("qml_repeater", "Main");

    return app.exec();
}
