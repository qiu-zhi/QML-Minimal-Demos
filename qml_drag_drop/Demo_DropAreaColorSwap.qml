import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root
    property int swapCount: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "颜色色块交换"
            description: "任意两个色块互相拖拽即可交换颜色：源携带 mimeData，目标 DropArea 在 onDropped 中完成数据交换"
        }

        // 3 × 3 色块网格，可互相拖拽交换
        Grid {
            id: grid
            Layout.alignment: Qt.AlignHCenter
            columns: 3
            spacing: 14

            property int cellSize: 100

            Repeater {
                id: colorRepeater
                model: ListModel {
                    id: colorModel
                    ListElement { c: "#FF6B6B"; t: "1" }
                    ListElement { c: "#4CAF50"; t: "2" }
                    ListElement { c: "#FFC107"; t: "3" }
                    ListElement { c: "#9C27B0"; t: "4" }
                    ListElement { c: "#1296FF"; t: "5" }
                    ListElement { c: "#FF9800"; t: "6" }
                    ListElement { c: "#00BCD4"; t: "7" }
                    ListElement { c: "#795548"; t: "8" }
                    ListElement { c: "#607D8B"; t: "9" }
                }

                delegate: Rectangle {
                    id: cell
                    width: grid.cellSize
                    height: grid.cellSize
                    radius: 12
                    color: model.c
                    opacity: dragHandler.active ? 0.3 : 1.0
                    border.color: dropHere.containsDrag ? "#333333" : "transparent"
                    border.width: dropHere.containsDrag ? 3 : 0

                    Behavior on border.width { NumberAnimation { duration: 120 } }
                    Behavior on opacity { NumberAnimation { duration: 120 } }

                    Text {
                        anchors.centerIn: parent
                        text: model.t
                        color: "white"
                        font.pointSize: 24
                        font.bold: true
                    }

                    // 用 DragHandler 驱动 Drag.active（Qt6 推荐，自动处理拖拽阈值）。
                    // dragType 默认 Drag.Automatic：拖拽时 Qt 自动渲染源块的半透明预览图跟随鼠标，
                    // 无需手写虚影；源色块保持原位，DropArea 根据拖拽位置接收 onDropped 完成数据交换
                    Drag.active: dragHandler.active
                    Drag.dragType: Drag.Automatic
                    Drag.supportedActions: Qt.CopyAction
                    Drag.mimeData: {
                        "text/index": index.toString(),
                        "text/color": model.c,
                        "text/label": model.t
                    }

                    DragHandler {
                        id: dragHandler
                        target: null
                        acceptedButtons: Qt.LeftButton
                        cursorShape: Qt.OpenHandCursor
                    }

                    // 同时作为放置区
                    DropArea {
                        id: dropHere
                        anchors.fill: parent

                        onEntered: (drag) => {
                            drag.accepted = drag.formats.indexOf("text/index") >= 0
                        }

                        onDropped: (drop) => {
                            var srcIndex = parseInt(drop.getDataAsString("text/index"))
                            if (srcIndex === index) {
                                drop.accepted = false
                                return
                            }
                            // 交换颜色与文字
                            var srcColor = colorModel.get(srcIndex).c
                            var srcText = colorModel.get(srcIndex).t
                            colorModel.setProperty(srcIndex, "c", model.c)
                            colorModel.setProperty(srcIndex, "t", model.t)
                            colorModel.setProperty(index, "c", srcColor)
                            colorModel.setProperty(index, "t", srcText)

                            statusText.text = "已交换：格子 " + (srcIndex + 1) + " ↔ 格子 " + (index + 1)
                            root.swapCount++
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
            text: "从一个色块拖到另一个色块上即可交换它们的颜色与编号"
            font.pointSize: 11
            color: "#666"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Button {
                text: "打乱排序"
                onClicked: {
                    // 随机交换 20 次
                    for (var i = 0; i < 20; i++) {
                        var a = Math.floor(Math.random() * colorModel.count)
                        var b = Math.floor(Math.random() * colorModel.count)
                        var ca = colorModel.get(a).c, ta = colorModel.get(a).t
                        colorModel.setProperty(a, "c", colorModel.get(b).c)
                        colorModel.setProperty(a, "t", colorModel.get(b).t)
                        colorModel.setProperty(b, "c", ca)
                        colorModel.setProperty(b, "t", ta)
                    }
                    statusText.text = "已随机打乱色块"
                }
            }

            Text {
                text: "累计交换次数: " + root.swapCount
                font.pointSize: 12
                color: "#1296FF"
                font.bold: true
            }
        }

        Item { Layout.fillHeight: true }
    }
}
