import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    property int nextId: 14
    // 模型就是一个普通数组，1~14 不用逐条声明 ListElement
    property var numbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "动态操作"
            description: "positionViewAtIndex 把指定项滚动进视野，currentIndex 选中某项，模型可随时追加或删除。"
        }

        // 操作区
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            SpinBox {
                id: jumpBox
                from: 0
                to: Math.max(0, root.numbers.length - 1)
                value: 12
                font.pointSize: 10
            }

            Button {
                text: "定位到该格"
                font.pointSize: 10
                enabled: root.numbers.length > 0
                onClicked: {
                    grid.positionViewAtIndex(jumpBox.value, GridView.Contain)
                    grid.currentIndex = jumpBox.value
                }
            }

            Button {
                text: "末尾追加"
                font.pointSize: 10
                onClicked: {
                    // 换成新数组会触发模型整体 reset，currentIndex 会被清空，
                    // 所以先记下来，等视图处理完更新再恢复
                    var keep = grid.currentIndex
                    root.numbers = root.numbers.concat(++root.nextId)
                    Qt.callLater(function() {
                        grid.positionViewAtIndex(root.numbers.length - 1, GridView.Contain)
                        if (keep >= 0)
                            grid.currentIndex = keep
                    })
                }
            }

            Button {
                text: "删除选中"
                font.pointSize: 10
                enabled: grid.currentIndex >= 0 && grid.currentIndex < root.numbers.length
                onClicked: {
                    var i = grid.currentIndex
                    root.numbers = root.numbers.slice(0, i).concat(root.numbers.slice(i + 1))
                    // reset 后恢复选中：优先原位置，删的是末尾项则前移一格
                    Qt.callLater(function() {
                        grid.currentIndex = Math.min(i, root.numbers.length - 1)
                    })
                }
            }

            Item { Layout.fillWidth: true }
        }

        // 内容卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            GridView {
                id: grid
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                focus: true

                cellWidth: 66
                cellHeight: 66
                model: root.numbers

                delegate: Item {
                    id: cell
                    required property int index
                    required property var modelData

                    width: grid.cellWidth
                    height: grid.cellHeight

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 5
                        radius: 8
                        color: cell.GridView.isCurrentItem ? "#1296FF" : "#FFFFFF"
                        border.color: "#e0e0e0"
                        border.width: 1

                        Behavior on color { ColorAnimation { duration: 120 } }

                        Text {
                            anchors.centerIn: parent
                            text: cell.modelData
                            color: cell.GridView.isCurrentItem ? "white" : "#333"
                            font.pointSize: 14
                            font.bold: true
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            grid.currentIndex = cell.index
                            grid.forceActiveFocus()
                        }
                    }
                }
            }
        }

        // 状态提示
        Text {
            Layout.fillWidth: true
            text: "共 %1 项 ｜ 当前 index：%2 ｜ 点击格子或用方向键切换选中项"
                    .arg(root.numbers.length)
                    .arg(grid.currentIndex)
            font.pointSize: 10
            color: "#666"
        }
    }
}