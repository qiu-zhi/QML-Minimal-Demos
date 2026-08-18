import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础自由拖拽"
            description: "使用 MouseArea 的 drag.target 实现元素自由拖拽，配合 drag.minimumX/Y 与 drag.maximumX/Y 限定活动范围"
        }

        // 拖拽画布
        Rectangle {
            id: canvas
            Layout.alignment: Qt.AlignHCenter
            width: 540
            height: 300
            radius: 10
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            // 网格背景，便于观察位置
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.strokeStyle = "#EEEEEE"
                    ctx.lineWidth = 1
                    for (var x = 0; x <= width; x += 30) {
                        ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, height); ctx.stroke()
                    }
                    for (var y = 0; y <= height; y += 30) {
                        ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(width, y); ctx.stroke()
                    }
                }
            }

            // 可拖拽方块
            Rectangle {
                id: dragBox
                width: 90
                height: 90
                radius: 12
                color: dragArea.pressed ? "#0E7BD9" : "#1296FF"
                x: canvas.width / 2 - 45
                y: canvas.height / 2 - 45

                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "拖我"
                    color: "white"
                    font.bold: true
                    font.pointSize: 14
                }

                Drag.active: dragArea.drag.active
                Drag.dragType: Drag.None

                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    drag.target: dragBox
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: canvas.width - dragBox.width
                    drag.minimumY: 0
                    drag.maximumY: canvas.height - dragBox.height
                    cursorShape: Qt.SizeAllCursor

                    onPositionChanged: statusText.text = "拖拽中…"
                    onReleased: {
                        statusText.text = "已释放  位置: (" + Math.round(dragBox.x) + ", " + Math.round(dragBox.y) + ")"
                    }
                }
            }

            // 状态提示
            Text {
                id: statusText
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 10
                text: "拖拽方块自由移动"
                font.pointSize: 12
                color: "#999"
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Text {
                text: "当前坐标: (" + Math.round(dragBox.x) + ", " + Math.round(dragBox.y) + ")"
                font.pointSize: 13
                color: "#1296FF"
                font.bold: true
            }

            Button {
                text: "重置位置"
                onClicked: {
                    dragBox.x = canvas.width / 2 - 45
                    dragBox.y = canvas.height / 2 - 45
                    statusText.text = "拖拽方块自由移动"
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 540
            text: "drag.axis: Drag.XAndYAxis  →  仅可在画布范围内移动（minimumX/Y ~ maximumX/Y）"
            font.pointSize: 10
            color: "#999"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        Item { Layout.fillHeight: true }
    }
}
