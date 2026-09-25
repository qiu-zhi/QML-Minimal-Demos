#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "datamodel_cpp.h"
#include "datamodel_proxy.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Demo 4：C++ 模型（少量数据，含搜索/增删改）
    DataModelCpp *modelCpp = new DataModelCpp(&engine);
    engine.rootContext()->setContextProperty("dataModelCpp", modelCpp);

    // Demo 5：ProxyModel（10万条大数据 + 实时过滤）
    DataModelProxy *modelProxy = new DataModelProxy(&engine);
    ContactProxyModel *proxyModel = new ContactProxyModel(&engine);
    proxyModel->setSourceModel(modelProxy);
    engine.rootContext()->setContextProperty("contactProxyModel", proxyModel);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("qml_listview", "Main");

    return app.exec();
}
