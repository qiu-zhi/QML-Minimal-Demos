#include "treemodel.h"

using namespace Qt::StringLiterals;

TreeModel::TreeModel(QObject *parent)
    : QAbstractItemModel(parent)
    , m_root(std::make_unique<TreeNode>(QString()))
{
    // 一份写死的目录数据，够展示层级就够了
    auto *src = m_root->appendChild(u"src"_s);
    src->appendChild(u"main.cpp"_s);
    src->appendChild(u"window.cpp"_s);

    auto *qml = m_root->appendChild(u"qml"_s);
    qml->appendChild(u"Main.qml"_s);
    qml->appendChild(u"Panel.qml"_s);

    auto *docs = m_root->appendChild(u"docs"_s);
    docs->appendChild(u"design.md"_s);

    m_root->appendChild(u"README.md"_s);
}

// 视图靠 index() / parent() / rowCount() 三者在树里上下走
QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return {};

    return createIndex(row, column, nodeOf(parent)->children.at(size_t(row)).get());
}

QModelIndex TreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return {};

    TreeNode *node = static_cast<TreeNode *>(index.internalPointer());
    // 顶层节点的父索引必须无效，否则视图会凭空多出一层看不见的根
    if (node->parent == m_root.get())
        return {};

    return createIndex(rowOf(node->parent), 0, node->parent);
}

int TreeModel::rowCount(const QModelIndex &parent) const
{
    // 树只在第一列展开，其余列没有子项
    if (parent.column() > 0)
        return 0;

    return int(nodeOf(parent)->children.size());
}

int TreeModel::columnCount(const QModelIndex &) const
{
    return 1; // 单列：一列就足够把树画出来
}

QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Qt::DisplayRole)
        return {};

    return nodeOf(index)->text;
}

TreeNode *TreeModel::nodeOf(const QModelIndex &index) const
{
    return index.isValid() ? static_cast<TreeNode *>(index.internalPointer()) : m_root.get();
}

int TreeModel::rowOf(const TreeNode *node) const
{
    const auto &siblings = node->parent->children;
    for (size_t row = 0; row < siblings.size(); ++row) {
        if (siblings.at(row).get() == node)
            return int(row);
    }
    return 0;
}
