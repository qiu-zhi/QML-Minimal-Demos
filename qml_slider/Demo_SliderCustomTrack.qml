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
            title: "自定义轨道"
            description: "完全自定义 Slider，包括背景轨道、已完成部分和手柄"
        }

        // 值显示
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Math.round(control.value)
            color: "#333"
            font.pointSize: 12
        }

        // 滑块
        Slider {
            id: control
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            from: 0
            to: 100
            value: 50

            // 背景轨道
            background: Rectangle {
                x: control.leftPadding
                y: control.topPadding + control.availableHeight / 2 - height / 2
                width: control.availableWidth
                height: 4
                radius: 2
                color: "#34495e"

                // 已完成部分
                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    color: "#2ecc71"
                    radius: 2
                }
            }

            // 手柄
            handle: Rectangle {
                x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                y: control.topPadding + control.availableHeight / 2 - height / 2
                width: 20
                height: 20
                radius: 10
                color: control.pressed ? "#13a333" : "#ecf0f1"
                border.color: "#2ecc71"
                border.width: 2

                // 手柄动画
                Behavior on color {
                    ColorAnimation { duration: 100 }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
