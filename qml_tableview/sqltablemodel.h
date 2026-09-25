#ifndef SQLTABLEMODEL_H
#define SQLTABLEMODEL_H

#include <QSqlTableModel>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QList>
#include <QDebug>

typedef struct People {
    QString name;
    int age;
}people_t;

class SqlTableModel : public QSqlTableModel
{
    Q_OBJECT
    // QML 里 rowCount 是方法（Q_INVOKABLE）不是属性，直接写进绑定会得到
    // "function(){ [native code] }"；而且方法调用不是响应式的，增删后不会刷新。
    // 暴露成属性 + NOTIFY，QML 侧的「共 N 条记录」才能在增删改后自动更新。
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    explicit SqlTableModel(QObject *parent = nullptr);

    int count() const { return rowCount(); }

    // 增加数据 name age
    Q_INVOKABLE void appendRow(const QString &name, int age);

    // 删除选中行数据
    Q_INVOKABLE void removeRow(int row);

    // 修改
    Q_INVOKABLE void editRow(int row, const QString &name, int age);

    // 获取指定单元格数据
    Q_INVOKABLE QVariant cell(int row, int col) const;

    // 保存
    Q_INVOKABLE bool saveAll();

signals:
    void countChanged();
};

#endif // SQLTABLEMODEL_H
