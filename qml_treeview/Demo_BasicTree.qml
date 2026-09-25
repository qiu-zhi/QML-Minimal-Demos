import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础树视图"
            description: "内置委托开箱即用：双击行展开或折叠"
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

                // 只接受 QAbstractItemModel，树数据由 C++ 的 TreeModel 提供
                model: TreeModel {}

                // 内置委托：缩进、展开折叠、选中高亮都由它包办
                delegate: TreeViewDelegate {
                    id: nodeDelegate
                    implicitHeight: 28 // 行高写 implicitHeight，TableView 一族会忽略 height
                    palette.highlight: "#1296FF"

                    // 内置箭头是位图，这里换成 SVG 图标；换掉 indicator 后它不再自动缩进
                    indicator: TreeArrow {
                        x: nodeDelegate.leftMargin + nodeDelegate.depth * nodeDelegate.indentation
                        y: (parent.height - height) / 2
                        expanded: nodeDelegate.expanded
                    }
                }

                // 有了选中模型，单击行才会成为当前行、由委托画出高亮
                selectionModel: ItemSelectionModel {}

                // 单列也铺满视图宽度，否则列宽只按文字长度算，行背景只铺一小截
                columnWidthProvider: function(column) { return treeView.width }

                // 初始全部展开，一进来就能看到完整的层级
                Component.onCompleted: expandRecursively()
            }
        }
    }
}
