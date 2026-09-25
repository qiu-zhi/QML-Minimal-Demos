#include "sqltablemodel.h"
#include <QSqlRecord>
#include <QSqlField>

SqlTableModel::SqlTableModel(QObject *parent)
    : QSqlTableModel(parent)
{
    setTable("people");
    setEditStrategy(OnManualSubmit);   // 手动提交，saveAll() 时一次性写入
    select();

    // 行数变化时通知 QML（select() 会触发 modelReset，增/删会触发 rowsInserted/rowsRemoved）
    connect(this, &QAbstractItemModel::modelReset,  this, &SqlTableModel::countChanged);
    connect(this, &QAbstractItemModel::rowsInserted, this, &SqlTableModel::countChanged);
    connect(this, &QAbstractItemModel::rowsRemoved,  this, &SqlTableModel::countChanged);
}

/* 增 */
void SqlTableModel::appendRow(const QString &name, int age)
{
    QSqlRecord r = record();   // 获得表结构
    r.setValue("name", name);
    r.setValue("age",  age);
    insertRecord(-1, r);       // -1 表示追加到末尾
}

/* 删：只删当前选中行（QML 里把 TableView.selection.currentRow 传进来）*/
void SqlTableModel::removeRow(int row)
{
    if (row < 0 || row >= rowCount())
        return;
    qDebug() << "row = " << row;

    // 仅标记删除，真正删除在 submitAll() 或 saveAll()
    QSqlTableModel::removeRow(row);
}

/* 改：修改指定行 */
void SqlTableModel::editRow(int row, const QString &name, int age)
{
    if (row < 0 || row >= rowCount())
        return;
    setData(index(row, fieldIndex("name")), name);
    setData(index(row, fieldIndex("age")),  age);
}

/* 获取指定单元格数据 */
QVariant SqlTableModel::cell(int row, int col) const
{
    return data(index(row, col), Qt::DisplayRole);
}

/* 保存：一次性提交所有增删改 */
bool SqlTableModel::saveAll()
{
    return submitAll();
}
