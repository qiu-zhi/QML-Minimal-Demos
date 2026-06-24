import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本动画"
            description: "演示文本相关动画效果：颜色渐变、透明度、缩放、打字机效果"
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 15

            // 颜色渐变
            Text {
                text: "颜色渐变动画"
                font.pointSize: 16
                font.bold: true
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#E91E63"; to: "#2196F3"; duration: 1500 }
                    ColorAnimation { from: "#2196F3"; to: "#4CAF50"; duration: 1500 }
                    ColorAnimation { from: "#4CAF50"; to: "#E91E63"; duration: 1500 }
                }
            }

            // 透明度闪烁
            Text {
                text: "透明度闪烁动画"
                font.pointSize: 16
                font.bold: true
                color: "#FF9800"
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { from: 1.0; to: 0.2; duration: 800; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 0.2; to: 1.0; duration: 800; easing.type: Easing.InOutQuad }
                }
            }

            // 缩放弹跳
            Text {
                id: bounceText
                text: "缩放弹跳动画"
                font.pointSize: 14
                font.bold: true
                color: "#9C27B0"
                scale: 1.0
                Layout.leftMargin: 15

                SequentialAnimation on scale {
                    loops: Animation.Infinite
                    NumberAnimation { from: 1.0; to: 1.2; duration: 500; easing.type: Easing.OutBack }
                    NumberAnimation { from: 1.2; to: 1.0; duration: 500; easing.type: Easing.InBack }
                }
            }

            // 打字机效果
            Text {
                id: typewriterText
                text: ""
                font.pointSize: 14
                color: "#333"

                property string fullText: "这是打字机逐字显示的效果..."
                property int charIndex: 0

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: {
                        if (typewriterText.charIndex <= typewriterText.fullText.length) {
                            typewriterText.text = typewriterText.fullText.substring(0, typewriterText.charIndex)
                            typewriterText.charIndex++
                        } else {
                            typewriterText.charIndex = 0
                        }
                    }
                }
            }

            // 滚动字幕
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                clip: true
                color: "#f5f5f5"
                border.color: "#ddd"
                radius: 4

                Text {
                    id: scrollText
                    text: "这是一段滚动字幕文本 >>> 持续滚动展示 >>> QML Text Animation Demo"
                    font.pointSize: 12
                    color: "#1976D2"
                    anchors.verticalCenter: parent.verticalCenter
                    x: parent.width

                    NumberAnimation on x {
                        from: scrollText.parent.width
                        to: -scrollText.width
                        duration: 8000
                        loops: Animation.Infinite
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
