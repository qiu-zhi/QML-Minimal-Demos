import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 源模型 + 过滤代理：TreeView 只负责把代理给的行画出来
    TreeModel { id: sourceModel }
    TreeSortFilterModel {
        id: proxyModel
        sourceModel: sourceModel
        filterText: filterField.text
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "搜索过滤"
            description: "用代理模型过滤，命中的节点连同它的父节点一起留下，过滤后自动展开"
        }

        // 控制条：关键字输入 + 命中计数
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            TextField {
                id: filterField
                Layout.preferredWidth: 230
                placeholderText: "输入关键字，如 qml / cpp"
                selectByMouse: true

                // 过滤一变就重新展开，命中的节点才看得见
                onTextChanged: treeView.expandRecursively()
            }

            Text {
                Layout.fillWidth: true
                text: proxyModel.filterText.length > 0
                      ? "命中 " + proxyModel.matchCount + " 个节点"
                      : "共 " + proxyModel.matchCount + " 个节点"
                color: "#888888"
                font.pixelSize: 12
            }
        }

        // 内容卡片：树垂直方向铺满剩余空间
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            TreeView {
                id: treeView
                anchors.fill: parent
                anchors.margins: 6
                clip: true
                ScrollBar.vertical: ScrollBar {}

                model: proxyModel

                delegate: TreeViewDelegate {
                    id: nodeDelegate
                    implicitHeight: 28
                    palette.highlight: "#1296FF"

                    // 内置箭头是位图，这里换成 SVG 图标；换掉 indicator 后它不再自动缩进
                    indicator: TreeArrow {
                        x: nodeDelegate.leftMargin + nodeDelegate.depth * nodeDelegate.indentation
                        y: (parent.height - height) / 2
                        expanded: nodeDelegate.expanded
                    }
                }

                selectionModel: ItemSelectionModel {}
                columnWidthProvider: function(column) { return treeView.width }

                Component.onCompleted: expandRecursively()
            }
        }
    }
}
