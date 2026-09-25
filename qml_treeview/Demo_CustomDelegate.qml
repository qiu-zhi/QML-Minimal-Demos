import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义委托"
            description: "自绘委托画成文件树：目录 / 文件图标、悬停高亮、当前行浅底加粗"
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

                model: TreeModel {}
                selectionModel: ItemSelectionModel {}
                columnWidthProvider: function(column) { return treeView.width }

                Component.onCompleted: expandRecursively()

                // 裸 Item 当委托：缩进、箭头、图标、高亮全部自己算（属性由视图注入）
                delegate: Item {
                    id: nodeItem

                    required property TreeView treeView
                    required property bool isTreeNode
                    required property bool expanded
                    required property bool hasChildren
                    required property int depth
                    required property int row
                    required property int column
                    required property var model

                    readonly property real indentation: 20
                    readonly property real padding: 6
                    readonly property real arrowSlot: 16 // 给箭头留的固定槽位，叶节点留空，同层图标才对得齐
                    readonly property bool isCurrent: nodeItem.row === nodeItem.treeView.currentRow

                    implicitHeight: 28

                    // 悬停底色 + 当前行底色（当前行用浅底，与内置委托的整行深底区分开）
                    Rectangle {
                        anchors.fill: parent
                        color: nodeItem.isCurrent ? "#E3F1FF" : (hoverHandler.hovered ? "#EDEDED" : "transparent")
                    }

                    // 当前行左侧的强调竖条
                    Rectangle {
                        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                        width: 3
                        visible: nodeItem.isCurrent
                        color: "#1296FF"
                    }

                    HoverHandler { id: hoverHandler }

                    // 箭头：SVG 图标，单击即展开 / 折叠（内置委托只认双击）
                    TreeArrow {
                        id: indicator
                        x: nodeItem.padding + nodeItem.depth * nodeItem.indentation
                        anchors.verticalCenter: parent.verticalCenter
                        visible: nodeItem.isTreeNode && nodeItem.hasChildren
                        expanded: nodeItem.expanded

                        TapHandler {
                            onSingleTapped: {
                                // 先把这一格设为当前项，否则行展开了高亮却不跟过来
                                const index = nodeItem.treeView.index(nodeItem.row, nodeItem.column)
                                nodeItem.treeView.selectionModel.setCurrentIndex(index, ItemSelectionModel.NoUpdate)
                                nodeItem.treeView.toggleExpanded(nodeItem.row)
                            }
                        }
                    }

                    // 图标：目录是文件夹（展开 / 折叠两张图），文件是一张纸
                    Image {
                        id: icon
                        x: nodeItem.padding + nodeItem.depth * nodeItem.indentation + nodeItem.arrowSlot
                        anchors.verticalCenter: parent.verticalCenter
                        width: 16
                        height: 16
                        source: nodeItem.hasChildren
                                ? (nodeItem.expanded ? "/icons/folder-open.svg" : "/icons/folder.svg")
                                : "/icons/file.svg"
                    }

                    // 节点文本：排在图标右边
                    Text {
                        id: contentLabel
                        x: icon.x + icon.width + 6
                        anchors.verticalCenter: parent.verticalCenter
                        text: nodeItem.model.display
                        color: nodeItem.isCurrent ? "#0B5FA5" : "#333333"
                        font.bold: nodeItem.isCurrent
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }
}
