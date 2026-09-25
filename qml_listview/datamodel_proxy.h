#ifndef DATAMODEL_PROXY_H
#define DATAMODEL_PROXY_H

#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QList>
#include <QString>

// ──────────────────────────────────────────────
// qml_listview_model 使用的数据模型
// 大数据量（10万条）+ QSortFilterProxyModel 过滤
// ──────────────────────────────────────────────

class ContactItemProxy {
public:
    ContactItemProxy(const QString &name, const QString &phone)
        : m_name(name), m_phone(phone) {}
    QString name()        const { return m_name; }
    QString phone()       const { return m_phone; }
    QString firstLetter() const { return m_name.isEmpty() ? "?" : m_name.left(1).toUpper(); }
private:
    QString m_name;
    QString m_phone;
};

class DataModelProxy : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        PhoneRole,
        FirstLetterRole
    };

    explicit DataModelProxy(QObject *parent = nullptr);

    int     rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE bool addContact(const QString &name, const QString &phone);
    Q_INVOKABLE bool removeContact(int index);
    Q_INVOKABLE bool editContact(int index, const QString &name, const QString &phone);

private:
    QList<ContactItemProxy> m_items;
};

class ContactProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QString filterString READ filterString WRITE setFilterString NOTIFY filterStringChanged)

public:
    explicit ContactProxyModel(QObject *parent = nullptr);

    QString filterString() const { return m_filterString; }
    void setFilterString(const QString &filterString);

    Q_INVOKABLE bool removeContact(int index);
    Q_INVOKABLE bool editContact(int index, const QString &name, const QString &phone);

signals:
    void filterStringChanged();

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

private:
    QString m_filterString;
};

#endif // DATAMODEL_PROXY_H



