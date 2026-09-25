#ifndef TREEPROXYMODEL_H
#define TREEPROXYMODEL_H

#include <QSortFilterProxyModel>
#include <QQmlEngine>

// 排序 + 过滤代理：TreeView 自己既不会排序也不会过滤，套一层代理模型就行
class TreeSortFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
    QML_NAMED_ELEMENT(TreeSortFilterModel)

    Q_PROPERTY(QString filterText READ filterText WRITE setFilterText NOTIFY filterTextChanged)
    Q_PROPERTY(bool ascending READ ascending WRITE setAscending NOTIFY ascendingChanged)
    Q_PROPERTY(int matchCount READ matchCount NOTIFY filterTextChanged)

public:
    explicit TreeSortFilterModel(QObject *parent = nullptr);

    QString filterText() const { return m_filterText; }
    void setFilterText(const QString &text);

    bool ascending() const { return m_ascending; }
    void setAscending(bool ascending);

    // 源模型里文本命中的节点数，不含"只为带出子节点而保留"的祖先
    int matchCount() const;

signals:
    void filterTextChanged();
    void ascendingChanged();

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const override;

private:
    QString m_filterText;
    bool m_ascending = true;
};

#endif // TREEPROXYMODEL_H
