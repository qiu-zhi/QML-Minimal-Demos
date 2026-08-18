import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    // 9 个格子，第 9 个为空槽（value === 0）
    ListModel {
        id: puzzleModel
        ListElement { value: 1 }
        ListElement { value: 2 }
        ListElement { value: 3 }
        ListElement { value: 4 }
        ListElement { value: 5 }
        ListElement { value: 6 }
        ListElement { value: 7 }
        ListElement { value: 8 }
        ListElement { value: 0 }
    }

    property int moveCount: 0

    function isSolved() {
        for (var i = 0; i < 8; i++) {
            if (puzzleModel.get(i).value !== i + 1) return false
        }
        return puzzleModel.get(8).value === 0
    }

    function checkWin() {
        if (isSolved()) {
            statusText.text = "🎉 拼图完成！共用了 " + root.moveCount + " 步"
            statusText.color = "#4CAF50"
        }
    }

    function shuffle() {
        for (var i = 0; i < 60; i++) {
            var a = Math.floor(Math.random() * 9)
            var b = Math.floor(Math.random() * 9)
            var va = puzzleModel.get(a).value
            puzzleModel.setProperty(a, "value", puzzleModel.get(b).value)
            puzzleModel.setProperty(b, "value", va)
        }
        root.moveCount = 0
        statusText.text = "已打乱拼图，拖动数字块到空格进行移动"
        statusText.color = "#666"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "网格数字拼图"
            description: "3×3 网格中 8 个数字块 + 1 个空槽，拖动任一数字块到空槽即可交换位置，按 1-8 顺序排列即获胜"
        }

        Grid {
            id: board
            Layout.alignment: Qt.AlignHCenter
            columns: 3
            spacing: 8
            property int cellSize: 90

            Repeater {
                model: puzzleModel

                delegate: Rectangle {
                    id: tile
                    width: board.cellSize
                    height: board.cellSize
                    radius: 10
                    // 空槽：浅色描边方块；数字块：主题色
                    color: value === 0
                           ? (emptyDrop.containsDrag ? "#EAF4FF" : "#F0F0F0")
                           : (dragHandler.active ? "#0E7BD9" : "#1296FF")
                    border.color: value === 0
                                  ? (emptyDrop.containsDrag ? "#1296FF" : "#CCCCCC")
                                  : "#0E7BD9"
                    border.width: value === 0 ? 2 : 0

                    Behavior on color { ColorAnimation { duration: 120 } }

                    Text {
                        anchors.centerIn: parent
                        text: value === 0 ? "" : value
                        color: "white"
                        font.pointSize: 32
                        font.bold: true
                        visible: value !== 0
                    }

                    // 数字块作为拖拽源（空槽不可拖）。
                    // 用 DragHandler 驱动 Drag.active（Qt6 推荐，自动处理拖拽阈值，
                    // 不破坏 Grid 布局）；源块位置由 Grid 管理，交换后自动吸附到新格子
                    Drag.active: dragHandler.active
                    Drag.dragType: Drag.Automatic
                    Drag.supportedActions: Qt.CopyAction
                    Drag.mimeData: {
                        "text/index": index.toString(),
                        "text/value": value.toString()
                    }

                    DragHandler {
                        id: dragHandler
                        target: null
                        enabled: value !== 0
                        acceptedButtons: Qt.LeftButton
                        cursorShape: value === 0 ? Qt.ArrowCursor : Qt.OpenHandCursor
                    }

                    // 仅空槽作为放置区
                    DropArea {
                        id: emptyDrop
                        anchors.fill: parent
                        enabled: value === 0

                        onEntered: (drag) => {
                            drag.accepted = drag.formats.indexOf("text/index") >= 0
                        }

                        onDropped: (drop) => {
                            var srcIndex = parseInt(drop.getDataAsString("text/index"))
                            if (srcIndex === index) {
                                drop.accepted = false
                                return
                            }
                            // 交换两个格子的数值
                            var srcValue = puzzleModel.get(srcIndex).value
                            puzzleModel.setProperty(srcIndex, "value", value)       // value 为空槽 0
                            puzzleModel.setProperty(index, "value", srcValue)        // 空槽接收数字

                            root.moveCount++
                            statusText.text = "第 " + root.moveCount + " 步：把 " + srcValue + " 移到空格"
                            statusText.color = "#666"
                            root.checkWin()
                            drop.accepted = true
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 480
            text: "拖动任一数字块到空格进行移动"
            font.pointSize: 12
            color: "#666"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Button {
                text: "打乱拼图"
                onClicked: root.shuffle()
            }

            Button {
                text: "恢复顺序"
                onClicked: {
                    for (var i = 0; i < 8; i++) puzzleModel.setProperty(i, "value", i + 1)
                    puzzleModel.setProperty(8, "value", 0)
                    root.moveCount = 0
                    statusText.text = "已恢复初始顺序"
                    statusText.color = "#666"
                }
            }

            Text {
                text: "步数: " + root.moveCount
                font.pointSize: 12
                color: "#1296FF"
                font.bold: true
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 480
            text: "提示：每块都可自由拖到空格交换，不限相邻。还原 1-8 顺序（空格在右下角）即完成"
            font.pointSize: 10
            color: "#999"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        Item { Layout.fillHeight: true }
    }
}
