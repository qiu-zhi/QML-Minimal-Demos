#include <QGuiApplication>
#include <QQmlApplicationEngine>

// TreeModel 通过 QML_NAMED_ELEMENT 注册到 qml_treeview 模块，
// 在 QML 中可直接使用 TreeModel {} 创建实例，无需在此手动注入。

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("qml_treeview", "Main");

    return app.exec();
}
