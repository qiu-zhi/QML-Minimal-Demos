#include "treeproxymodel.h"

namespace {

// 递归数一遍源模型里文本命中的节点（关键字为空时就是全部节点）
int countMatches(const QAbstractItemModel *model, const QModelIndex &parent, const QString &needle)
{
    int count = 0;
    for (int row = 0; row < model->rowCount(parent); ++row) {
        const QModelIndex index = model->index(row, 0, parent);
        const QString text = model->data(index, Qt::DisplayRole).toString();
        if (needle.isEmpty() || text.contains(needle, Qt::CaseInsensitive))
            ++count;
        count += countMatches(model, index, needle);
    }
    return count;
}

} // namespace

TreeSortFilterModel::TreeSortFilterModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
    // 关键一步：命中的节点就算父节点不匹配也要留下，否则过滤完树就断了
    setRecursiveFilteringEnabled(true);
    setSortRole(Qt::DisplayRole);
    sort(0, Qt::AscendingOrder);
}

void TreeSortFilterModel::setFilterText(const QString &text)
{
    if (m_filterText == text)
        return;

    // 告诉代理"过滤条件要变了"，改完再让它重新过一遍（Qt 6.9 起取代 invalidateFilter）
    beginFilterChange();
    m_filterText = text;
    endFilterChange();

    emit filterTextChanged();
}

void TreeSortFilterModel::setAscending(bool ascending)
{
    if (m_ascending == ascending)
        return;

    m_ascending = ascending;
    // 排序按层级进行：同一父节点下的子节点重排，父节点不会脱离自己的子树
    sort(0, m_ascending ? Qt::AscendingOrder : Qt::DescendingOrder);
    emit ascendingChanged();
}

bool TreeSortFilterModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    if (m_filterText.isEmpty())
        return true;

    const QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);
    return sourceModel()->data(index, Qt::DisplayRole).toString().contains(m_filterText,
                                                                          Qt::CaseInsensitive);
}

int TreeSortFilterModel::matchCount() const
{
    return sourceModel() ? countMatches(sourceModel(), QModelIndex(), m_filterText) : 0;
}
