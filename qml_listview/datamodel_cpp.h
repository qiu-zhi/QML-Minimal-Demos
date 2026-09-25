#ifndef DATAMODEL_CPP_H
#define DATAMODEL_CPP_H

#include <QAbstractListModel>
#include <QList>
#include <QString>

// ──────────────────────────────────────────────
// qml_listview_cpp 使用的数据模型
// 联系人条目（少量数据，支持搜索/增删改）
// ──────────────────────────────────────────────

class ContactItemCpp {
public:
    ContactItemCpp(const QString &name, const QString &phone)
        : m_name(name), m_phone(phone) {}
    QString name()        const { return m_name; }
    QString phone()       const { return m_phone; }
    QString firstLetter() const { return m_name.isEmpty() ? "?" : m_name.left(1).toUpper(); }
private:
    QString m_name;
    QString m_phone;
};

class DataModelCpp : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        PhoneRole,
        FirstLetterRole
    };

    explicit DataModelCpp(QObject *parent = nullptr);

    int     rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE bool addContact(const QString &name, const QString &phone);
    Q_INVOKABLE bool removeContact(int index);
    Q_INVOKABLE bool editContact(int index, const QString &name, const QString &phone);
    Q_INVOKABLE QVariantList searchContacts(const QString &keyword);
    Q_INVOKABLE void clearSearch();

private:
    QList<ContactItemCpp> m_items;
    QList<ContactItemCpp> m_originalItems;
};

#endif // DATAMODEL_CPP_H



