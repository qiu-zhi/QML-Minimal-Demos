// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

/*
    treemodel.cpp
    Provides a simple tree model to show how to create and use hierarchical
    models.
*/

#include "treemodel.h"
#include <QFile>
#include <QStringList>
#include <QStack>

using namespace Qt::StringLiterals;

TreeModel::TreeModel(QObject *parent)
    : QAbstractItemModel(parent)
    , rootItem(std::make_unique<TreeItem>(QVariantList{tr("Title"), tr("Summary")}))
{
    QFile file(":/content.txt"_L1);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    setupModelData(QStringView{QString::fromUtf8(file.readAll())}.split(u'\n'), rootItem.get());
    file.close();
}

TreeModel::~TreeModel() = default;

int TreeModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return static_cast<TreeItem*>(parent.internalPointer())->columnCount();
    return rootItem->columnCount();
}

QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Qt::DisplayRole)
        return {};

    const auto *item = static_cast<const TreeItem*>(index.internalPointer());
    return item->data(index.column());
}

Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const
{
    return index.isValid()
               ? QAbstractItemModel::flags(index) : Qt::ItemFlags(Qt::NoItemFlags);
}

QVariant TreeModel::headerData(int section, Qt::Orientation orientation,
                               int role) const
{
    return orientation == Qt::Horizontal && role == Qt::DisplayRole
               ? rootItem->data(section) : QVariant{};
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return {};

    TreeItem *parentItem = parent.isValid()
                               ? static_cast<TreeItem*>(parent.internalPointer())
                               : rootItem.get();

    if (auto *childItem = parentItem->child(row))
        return createIndex(row, column, childItem);
    return {};
}

QModelIndex TreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return {};

    auto *childItem = static_cast<TreeItem*>(index.internalPointer());
    TreeItem *parentItem = childItem->parentItem();

    return parentItem != rootItem.get()
               ? createIndex(parentItem->row(), 0, parentItem) : QModelIndex{};
}

int TreeModel::rowCount(const QModelIndex &parent) const
{
    if (parent.column() > 0)
        return 0;

    const TreeItem *parentItem = parent.isValid()
                                     ? static_cast<const TreeItem*>(parent.internalPointer())
                                     : rootItem.get();

    return parentItem->childCount();
}

void TreeModel::setupModelData(const QList<QStringView> &lines, TreeItem *parent)
{
    struct ParentIndentation
    {
        TreeItem *parent;
        qsizetype indentation;
    };

    QStack<ParentIndentation> state;
    state.push({parent, 0});

    for (const auto &line : lines) {
        qsizetype position = 0;
        for ( ; position < line.length() && line.at(position).isSpace(); ++position) {
        }

        const QStringView lineData = line.sliced(position).trimmed();
        if (!lineData.isEmpty()) {
            // Read the column data from the rest of the line.
            const auto columnStrings = lineData.split(u'\t', Qt::SkipEmptyParts);
            QVariantList columnData;
            columnData.reserve(columnStrings.count());
            for (const auto &columnString : columnStrings)
                columnData << columnString.toString();

            if (position > state.top().indentation) {
                // The last child of the current parent is now the new parent
                // unless the current parent has no children.
                auto *lastParent = state.top().parent;
                if (lastParent->childCount() > 0)
                    state.push({lastParent->child(lastParent->childCount() - 1), position});
            } else {
                while (position < state.top().indentation && !state.isEmpty())
                    state.pop();
            }

            // Append a new item to the current parent's list of children.
            auto *lastParent = state.top().parent;
            lastParent->appendChild(std::make_unique<TreeItem>(columnData, lastParent));
        }
    }
}

TreeItem::TreeItem(QVariantList data, TreeItem *parent)
    : m_itemData(std::move(data)), m_parentItem(parent)
{}

void TreeItem::appendChild(std::unique_ptr<TreeItem> &&child)
{
    m_childItems.push_back(std::move(child));
}

TreeItem *TreeItem::child(int row)
{
    return row >= 0 && row < childCount() ? m_childItems.at(row).get() : nullptr;
}

int TreeItem::childCount() const
{
    return int(m_childItems.size());
}

int TreeItem::columnCount() const
{
    return int(m_itemData.count());
}

QVariant TreeItem::data(int column) const
{
    return m_itemData.value(column);
}

TreeItem *TreeItem::parentItem()
{
    return m_parentItem;
}

int TreeItem::row() const
{
    if (m_parentItem == nullptr)
        return 0;
    const auto it = std::find_if(m_parentItem->m_childItems.cbegin(), m_parentItem->m_childItems.cend(),
                                 [this](const std::unique_ptr<TreeItem> &treeItem) {
                                     return treeItem.get() == this;
                                 });

    if (it != m_parentItem->m_childItems.cend())
        return std::distance(m_parentItem->m_childItems.cbegin(), it);
    Q_ASSERT(false); // should not happen
    return -1;
}
