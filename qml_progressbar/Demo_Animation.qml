import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "进度条动画"
            description: "通过 Behavior 为进度条宽度变化添加动画，配合 Timer 模拟进度的自动更新"
        }

        ProgressBar {
            id: control
            Layout.fillWidth: true
            height: 24

            from: 0
            to: 100
            value: 30

            background: Rectangle {
                color: "#eee"
                border.color: "#ccc"
                border.width: 1.5
                radius: 4
            }

            contentItem: Item {
                anchors.margins: 4
                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    radius: 4
                    clip: true

                    // 蓝→青渐变填充，让动画中的进度更有层次
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#4facfe" }
                        GradientStop { position: 1.0; color: "#00f2fe" }
                    }

                    // 顶部高光：模拟光泽感
                    Rectangle {
                        anchors { left: parent.left; right: parent.right; top: parent.top }
                        height: parent.height / 3
                        color: "white"
                        opacity: 0.25
                    }

                    Behavior on width {
                        NumberAnimation { duration: 500 }  // 添加宽度变化的动画效果
                    }
                }
            }
        }

        Timer {
            id: timer
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                if (control.value < control.to) {
                    control.value += 10;
                } else {
                    control.value = 30;
                }
            }
        }

        Text {
            text: "进度值: " + control.value
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
