#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSqlDatabase>
#include <QSqlQuery>
#include "sqltablemodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    /* 1. 建库/建表 */
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("people.db");
    if (!db.open()) qFatal("open db error");

    QSqlQuery query(db);
    query.exec("CREATE TABLE IF NOT EXISTS people ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT, "
               "name TEXT, "
               "age  INTEGER)");

    /* 1.1 表为空时填入演示数据：否则示例一打开是空表格，
       且没有行可选中，删除/修改两个按钮始终不可用 */
    query.exec("SELECT COUNT(*) FROM people");
    if (query.next() && query.value(0).toInt() == 0) {
        query.exec("INSERT INTO people (name, age) VALUES"
                   "('张三', 25), ('李四', 30), ('王五', 28), ('赵六', 35)");
    }

    /* 2. 实例化模型并注册到 QML */
    SqlTableModel *sqlModel = new SqlTableModel(&app);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("sqlModel", sqlModel);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("qml_tableview", "Main");

    return app.exec();
}
