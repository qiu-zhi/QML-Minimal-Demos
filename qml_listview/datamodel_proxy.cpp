#include "datamodel_proxy.h"
#include <QRandomGenerator>
#include <QDateTime>
#include <QDebug>

// 随机生成姓名（00后）
static QString generateRandomName()
{
    static const QStringList familyNames = {
        "张","王","李","赵","刘","陈","杨","黄","周","吴",
        "徐","孙","胡","朱","高","林","何","郭","马","罗"
    };
    static const QStringList givenNames1 = {
        "浠","梓","语","欣","萱","可","奕","宸","沐","熙",
        "辰","墨","玥","悦","晨","子","雨","芯","曦","瑾"
    };
    static const QStringList givenNames2 = {
        "宇","轩","铭","泽","睿","晟","翊","然","乐","萌",
        "希","瑶","茗","淇","雅","彤","清","菡","锦","颜"
    };
    return familyNames[QRandomGenerator::global()->bounded(familyNames.size())] +
           givenNames1[QRandomGenerator::global()->bounded(givenNames1.size())] +
           givenNames2[QRandomGenerator::global()->bounded(givenNames2.size())];
}

static QString generateRandomPhone()
{
    static const QStringList prefixes = {
        "133","135","136","137","138","139",
        "150","151","152","157","158","159","188","189"
    };
    QString phone = prefixes[QRandomGenerator::global()->bounded(prefixes.size())];
    for (int i = 0; i < 8; ++i)
        phone += QString::number(QRandomGenerator::global()->bounded(10));
    return phone;
}

DataModelProxy::DataModelProxy(QObject *parent)
    : QAbstractListModel(parent)
{
    qint64 startTime = QDateTime::currentMSecsSinceEpoch();
    m_items.reserve(100000);
    beginInsertRows(QModelIndex(), 0, 99999);
    for (int i = 0; i < 100000; ++i)
        m_items.append(ContactItemProxy(generateRandomName(), generateRandomPhone()));
    endInsertRows();
    qint64 endTime = QDateTime::currentMSecsSinceEpoch();
    qDebug() << "添加10万条数据耗时:" << (endTime - startTime) << "毫秒";
}

int DataModelProxy::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_items.count();
}

QVariant DataModelProxy::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.count())
        return QVariant();
    const ContactItemProxy &item = m_items.at(index.row());
    switch (role) {
    case NameRole:        return item.name();
    case PhoneRole:       return item.phone();
    case FirstLetterRole: return item.firstLetter();
    default:              return QVariant();
    }
}

QHash<int, QByteArray> DataModelProxy::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole]        = "name";
    roles[PhoneRole]       = "phone";
    roles[FirstLetterRole] = "firstLetter";
    return roles;
}

bool DataModelProxy::addContact(const QString &name, const QString &phone)
{
    if (name.isEmpty() || phone.isEmpty()) return false;
    beginInsertRows(QModelIndex(), m_items.count(), m_items.count());
    m_items.append(ContactItemProxy(name, phone));
    endInsertRows();
    return true;
}

bool DataModelProxy::removeContact(int index)
{
    if (index < 0 || index >= m_items.count()) return false;
    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
    return true;
}

bool DataModelProxy::editContact(int index, const QString &name, const QString &phone)
{
    if (index < 0 || index >= m_items.count() || name.isEmpty() || phone.isEmpty())
        return false;
    m_items[index] = ContactItemProxy(name, phone);
    emit dataChanged(createIndex(index, 0), createIndex(index, 0));
    return true;
}

// ── ContactProxyModel ──────────────────────────────────────

ContactProxyModel::ContactProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    setFilterCaseSensitivity(Qt::CaseInsensitive);
    setSortCaseSensitivity(Qt::CaseInsensitive);
}

void ContactProxyModel::setFilterString(const QString &filterString)
{
    if (m_filterString != filterString) {
        m_filterString = filterString;
        emit filterStringChanged();
        invalidateFilter();
    }
}

bool ContactProxyModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    if (m_filterString.isEmpty()) return true;
    QModelIndex nameIndex  = sourceModel()->index(sourceRow, 0, sourceParent);
    QString name  = sourceModel()->data(nameIndex, DataModelProxy::NameRole).toString();
    QString phone = sourceModel()->data(nameIndex, DataModelProxy::PhoneRole).toString();
    return name.contains(m_filterString,  Qt::CaseInsensitive) ||
           phone.contains(m_filterString, Qt::CaseInsensitive);
}

bool ContactProxyModel::removeContact(int index)
{
    if (DataModelProxy *model = qobject_cast<DataModelProxy*>(sourceModel())) {
        QModelIndex sourceIndex = mapToSource(this->index(index, 0));
        return model->removeContact(sourceIndex.row());
    }
    return false;
}

bool ContactProxyModel::editContact(int index, const QString &name, const QString &phone)
{
    if (DataModelProxy *model = qobject_cast<DataModelProxy*>(sourceModel())) {
        QModelIndex sourceIndex = mapToSource(this->index(index, 0));
        return model->editContact(sourceIndex.row(), name, phone);
    }
    return false;
}



