import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // TreeView 只认 QAbstractItemModel，排序自己不做，交给代理模型
    TreeModel { id: sourceModel }
    TreeSortFilterModel { id: proxyModel; sourceModel: sourceModel }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "名称排序"
            description: "套一层代理模型来排序，同级节点重排，父节点始终跟着自己的子树"
        }

        // 控制条：切升序 / 降序
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Button {
                text: proxyModel.ascending ? "升序 A → Z" : "降序 Z → A"
                onClicked: proxyModel.ascending = !proxyModel.ascending
            }

            Text {
                Layout.fillWidth: true
                text: "点击按钮切换"
                color: "#888"
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

                // 换成代理模型：排序结果由它给出
                model: proxyModel

                delegate: TreeViewDelegate {
                    id: nodeDelegate
                    implicitHeight: 28
                    palette.highlight: "#1296FF"

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
