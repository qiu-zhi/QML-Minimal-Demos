#ifndef TREEMODEL_H
#define TREEMODEL_H

#include <QAbstractItemModel>
#include <QQmlEngine>
#include <memory>
#include <vector>

// 树节点：一个名字 + 一串子节点
struct TreeNode
{
    TreeNode(const QString &text, TreeNode *parent = nullptr)
        : text(text), parent(parent) {}

    TreeNode *appendChild(const QString &childText)
    {
        children.push_back(std::make_unique<TreeNode>(childText, this));
        return children.back().get();
    }

    QString text;
    TreeNode *parent = nullptr;
    std::vector<std::unique_ptr<TreeNode>> children;
};

// 最小树模型：TreeView 只接受 QAbstractItemModel，树数据必须由 C++ 提供
class TreeModel : public QAbstractItemModel
{
    Q_OBJECT
    QML_NAMED_ELEMENT(TreeModel)

public:
    explicit TreeModel(QObject *parent = nullptr);

    QModelIndex index(int row, int column, const QModelIndex &parent = {}) const override;
    QModelIndex parent(const QModelIndex &index) const override;
    int rowCount(const QModelIndex &parent = {}) const override;
    int columnCount(const QModelIndex &parent = {}) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
    TreeNode *nodeOf(const QModelIndex &index) const;
    int rowOf(const TreeNode *node) const;

    // 不可见根：它的子节点就是树的第一层，视图不会把它显示出来
    std::unique_ptr<TreeNode> m_root;
};

#endif // TREEMODEL_H
