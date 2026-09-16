#include "itemmodel.h"

ItemModel::ItemModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // 初始化一些示例数据
    m_items.append({"Item1", "#3498db", "from C++"});
    m_items.append({"Item2", "#e74c3c", "from C++"});
    m_items.append({"Item3", "#2ecc71", "from C++"});
    m_items.append({"Item4", "#f39c12", "from C++"});
}

int ItemModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : m_items.size();
}

QVariant ItemModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const Item &item = m_items.at(index.row());

    switch (role) {
    case NameRole:
        return item.name;
    case ColorRole:
        return item.color;
    case DesRole:
        return item.des;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ItemModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[ColorRole] = "color";
    roles[DesRole] = "des";
    return roles;
}

int ItemModel::count() const
{
    return m_items.size();
}

void ItemModel::addItem()
{
    static const QStringList colors = {"#3498db", "#e74c3c", "#2ecc71", "#f39c12"};

    const int row = m_items.size();
    beginInsertRows(QModelIndex(), row, row);
    m_items.append({QString("Item%1").arg(row + 1),
                    colors.at(row % colors.size()),
                    QStringLiteral("from C++")});
    endInsertRows();

    emit countChanged();
}

void ItemModel::removeLastItem()
{
    if (m_items.isEmpty())
        return;

    const int row = m_items.size() - 1;
    beginRemoveRows(QModelIndex(), row, row);
    m_items.removeAt(row);
    endRemoveRows();

    emit countChanged();
}
