#ifndef ITEMMODEL_H
#define ITEMMODEL_H

#include <QAbstractListModel>
#include <QStringList>
#include <QVector>

struct Item {
    QString name;
    QString color;
    QString des;
};

class ItemModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum FruitRoles {
        NameRole = Qt::UserRole + 1,
        ColorRole,
        DesRole
    };

    explicit ItemModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    int count() const;

    // 供 QML 的增删按钮调用：必须包在 begin/end 之间，Repeater 才会同步增删委托
    Q_INVOKABLE void addItem();
    Q_INVOKABLE void removeLastItem();

signals:
    void countChanged();

private:
    QVector<Item> m_items;
};

#endif
