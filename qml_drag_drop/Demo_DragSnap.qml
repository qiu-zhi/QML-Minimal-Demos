import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "拖拽吸附"
            description: "拖动色块靠近目标区域，进入吸附半径后松手自动吸附到目标中心"
        }

        // 拖拽画布
        Rectangle {
            id: canvas
            Layout.alignment: Qt.AlignHCenter
            width: 540
            height: 340
            radius: 10
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            // 吸附目标位置（画布中心）
            property real snapX: width / 2
            property real snapY: height / 2
            property real snapRadius: radiusSlider.value

            // 吸附半径圆圈（虚线，拖拽时显示）
            Canvas {
                id: snapCanvas
                anchors.centerIn: parent
                width: canvas.snapRadius * 2
                height: canvas.snapRadius * 2
                visible: dragMouse.pressed

                property bool inRange: false

                onPaint: {
                    var ctx = getContext("2d")
                    var r = width / 2
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.arc(r, r, r - 1, 0, 2 * Math.PI)
                    ctx.strokeStyle = inRange
                                     ? Qt.rgba(0.07, 0.59, 1.0, 0.6)
                                     : Qt.rgba(0.07, 0.59, 1.0, 0.2)
                    ctx.lineWidth = inRange ? 3 : 2
                    ctx.setLineDash([6, 4])
                    ctx.stroke()
                }

                Connections {
                    target: dragBlock
                    function onXChanged() { snapCanvas.inRange = snapCanvas.checkRange(); snapCanvas.requestPaint() }
                    function onYChanged() { snapCanvas.inRange = snapCanvas.checkRange(); snapCanvas.requestPaint() }
                }

                function checkRange() {
                    var dx = dragBlock.x + dragBlock.width / 2 - canvas.snapX
                    var dy = dragBlock.y + dragBlock.height / 2 - canvas.snapY
                    // 色块边缘碰到虚线圈即算进入范围
                    var dist = Math.sqrt(dx * dx + dy * dy)
                    return dist - dragBlock.width / 2 < canvas.snapRadius
                }
            }

            // 吸附目标方块
            Rectangle {
                anchors.centerIn: parent
                width: 70
                height: 70
                radius: 14
                color: snapCanvas.inRange ? "#FFD6D6" : "#FFCDD2"
                border.color: snapCanvas.inRange ? "#FF6B6B" : "#FFCDD2"
                border.width: snapCanvas.inRange ? 3 : 1

                Behavior on border.width { NumberAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "目标"
                    color: "#FF6B6B"
                    font.pointSize: 14
                    font.bold: true
                }
            }

            // 可拖拽色块
            Rectangle {
                id: dragBlock
                width: 60
                height: 60
                radius: 12
                color: dragMouse.pressed ? "#0E7BD9" : "#1296FF"
                x: 40
                y: 140

                Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.OutBack } }
                Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.OutBack } }
                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "拖我"
                    color: "white"
                    font.pointSize: 14
                    font.bold: true
                }

                MouseArea {
                    id: dragMouse
                    anchors.fill: parent
                    drag.target: dragBlock
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: canvas.width - dragBlock.width
                    drag.minimumY: 0
                    drag.maximumY: canvas.height - dragBlock.height
                    cursorShape: Qt.OpenHandCursor

                    onReleased: {
                        if (snapCanvas.inRange) {
                            dragBlock.x = canvas.snapX - dragBlock.width / 2
                            dragBlock.y = canvas.snapY - dragBlock.height / 2
                            statusText.text = "已吸附到目标中心"
                        } else {
                            statusText.text = "未进入吸附范围，色块停留在原位"
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 540
            text: "拖动色块靠近目标，进入吸附半径后松手即可自动吸附"
            font.pointSize: 11
            color: "#666"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 16

            Text {
                text: "吸附半径:"
                font.pointSize: 12
                color: "#333"
                font.bold: true
            }

            Slider {
                id: radiusSlider
                from: 30
                to: 120
                value: 70
                stepSize: 5
                Layout.preferredWidth: 240
            }

            Text {
                text: Math.round(radiusSlider.value) + " px"
                font.pointSize: 12
                color: "#1296FF"
                font.bold: true
                Layout.preferredWidth: 50
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "重置位置"
                onClicked: {
                    dragBlock.x = 40
                    dragBlock.y = 140
                    statusText.text = "色块已重置"
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
