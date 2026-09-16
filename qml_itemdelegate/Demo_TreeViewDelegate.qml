import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "TreeViewDelegate 树形列表"
            description: "树形视图委托，使用 C++ TreeModel 加载层级数据，支持展开 / 折叠"
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

                selectionModel: ItemSelectionModel {}

                // 只接受 QAbstractItemModel 类型的模型
                model: TreeModel { }

                delegate: TreeViewDelegate {
                    id: viewDelegate
                    readonly property real _padding: 5
                    readonly property real szHeight: contentItem.implicitHeight * 2

                    implicitWidth: _padding + contentItem.x + contentItem.implicitWidth + _padding
                    implicitHeight: szHeight

                    // 背景矩形，用于显示交替行颜色
                    background: Rectangle {
                        anchors.fill: parent
                        color: viewDelegate.row === treeView.currentRow ? "#1296ff" :
                                                             (treeView.alternatingRows && viewDelegate.row % 2 !== 0) ? "#fff" : "#eee"
                    }

                    indicator: Item {
                        x: viewDelegate._padding + viewDelegate.depth * viewDelegate.indentation
                        implicitWidth: viewDelegate.szHeight
                        implicitHeight: viewDelegate.szHeight
                        visible: viewDelegate.isTreeNode && viewDelegate.hasChildren
                        rotation: viewDelegate.expanded ? 90 : 0

                        TapHandler {
                            onSingleTapped: {
                                let index = viewDelegate.treeView.index(viewDelegate.model.row, viewDelegate.model.column)
                                viewDelegate.treeView.selectionModel.setCurrentIndex(index, ItemSelectionModel.NoUpdate)
                                viewDelegate.treeView.toggleExpanded(viewDelegate.model.row)
                            }
                        }

                        ColorImage {
                            width: parent.width / 2
                            height: parent.height / 2
                            anchors.centerIn: parent
                            source: "qrc:/arrow_icon.png"
                            color: "#666"
                        }
                    }

                    contentItem: Label {
                        x: viewDelegate._padding + (viewDelegate.depth + 1) * viewDelegate.indentation
                        width: parent.width - viewDelegate._padding - x
                        text: viewDelegate.model.display
                        elide: Text.ElideRight
                        color: viewDelegate.row === treeView.currentRow ? "#fff" : "#333"
                    }
                }
            }
        }
    }
}
