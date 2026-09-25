#include "datamodel_cpp.h"

DataModelCpp::DataModelCpp(QObject *parent)
    : QAbstractListModel(parent)
{
    m_items.append(ContactItemCpp("张三", "13800138000"));
    m_items.append(ContactItemCpp("李四", "13900139000"));
    m_items.append(ContactItemCpp("王五", "13700137000"));
    m_originalItems = m_items;
}

int DataModelCpp::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_items.count();
}

QVariant DataModelCpp::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.count())
        return QVariant();

    const ContactItemCpp &item = m_items.at(index.row());
    switch (role) {
    case NameRole:        return item.name();
    case PhoneRole:       return item.phone();
    case FirstLetterRole: return item.firstLetter();
    default:              return QVariant();
    }
}

QHash<int, QByteArray> DataModelCpp::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole]        = "name";
    roles[PhoneRole]       = "phone";
    roles[FirstLetterRole] = "firstLetter";
    return roles;
}

bool DataModelCpp::addContact(const QString &name, const QString &phone)
{
    if (name.isEmpty() || phone.isEmpty()) return false;
    beginInsertRows(QModelIndex(), m_items.count(), m_items.count());
    m_items.append(ContactItemCpp(name, phone));
    m_originalItems = m_items;
    endInsertRows();
    return true;
}

bool DataModelCpp::removeContact(int index)
{
    if (index < 0 || index >= m_items.count()) return false;
    const ContactItemCpp &itemToRemove = m_items.at(index);
    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
    for (int i = 0; i < m_originalItems.count(); ++i) {
        if (m_originalItems.at(i).name() == itemToRemove.name() &&
            m_originalItems.at(i).phone() == itemToRemove.phone()) {
            m_originalItems.removeAt(i);
            break;
        }
    }
    return true;
}

bool DataModelCpp::editContact(int index, const QString &name, const QString &phone)
{
    if (index < 0 || index >= m_items.count() || name.isEmpty() || phone.isEmpty())
        return false;
    const ContactItemCpp &itemToEdit = m_items.at(index);
    ContactItemCpp newItem(name, phone);
    m_items[index] = newItem;
    emit dataChanged(createIndex(index, 0), createIndex(index, 0));
    for (int i = 0; i < m_originalItems.count(); ++i) {
        if (m_originalItems.at(i).name() == itemToEdit.name() &&
            m_originalItems.at(i).phone() == itemToEdit.phone()) {
            m_originalItems[i] = newItem;
            break;
        }
    }
    return true;
}

QVariantList DataModelCpp::searchContacts(const QString &keyword)
{
    if (keyword.isEmpty()) {
        beginResetModel();
        m_items = m_originalItems;
        endResetModel();
        return QVariantList();
    }
    beginResetModel();
    m_items.clear();
    for (const ContactItemCpp &item : m_originalItems) {
        if (item.name().contains(keyword, Qt::CaseInsensitive) ||
            item.phone().contains(keyword, Qt::CaseInsensitive)) {
            m_items.append(item);
        }
    }
    endResetModel();
    return QVariantList();
}

void DataModelCpp::clearSearch()
{
    beginResetModel();
    m_items = m_originalItems;
    endResetModel();
}



