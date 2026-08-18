import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "滚轮缩放"
            description: "通过 onWheel 信号捕获滚轮事件，实现元素的缩放与旋转"
        }

        Rectangle {
            id: canvas
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            Rectangle {
                id: target
                anchors.centerIn: parent
                width: 120
                height: 120
                radius: 12
                color: "#1296FF"
                scale: 1.0
                rotation: 0

                Behavior on scale {
                    NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                }
                Behavior on rotation {
                    NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                }

                Text {
                    anchors.centerIn: parent
                    text: "滚轮\n缩放/旋转"
                    color: "white"
                    font.pointSize: 13
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                onWheel: (wheel) => {
                    if (wheel.modifiers & Qt.ControlModifier) {
                        // Ctrl + 滚轮: 旋转
                        target.rotation += wheel.angleDelta.y / 8
                        statusText.text = "旋转: " + Math.round(target.rotation) + "°"
                    } else {
                        // 普通滚轮: 缩放
                        var newScale = target.scale + wheel.angleDelta.y / 1200
                        target.scale = Math.max(0.3, Math.min(3.0, newScale))
                        statusText.text = "缩放: " + target.scale.toFixed(2) + "x"
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            text: "缩放: 1.00x"
            font.pointSize: 13
            color: "#1296FF"
            font.bold: true
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "提示：滚轮缩放，Ctrl + 滚轮旋转"
            font.pointSize: 10
            color: "#999"
        }
    }
}
