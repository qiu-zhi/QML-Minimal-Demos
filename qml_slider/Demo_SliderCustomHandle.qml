import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义手柄"
            description: "自定义手柄样式，使用 QtQuick.Controls.Basic 实现基础定制"
        }

        Slider {
            id: control
            Layout.fillWidth: true

            from: 0
            to: 100
            value: 50
            stepSize: 5

            handle: Rectangle {
                x: parent.leftPadding + (parent.horizontal ? parent.visualPosition * (parent.availableWidth - width) : (parent.availableWidth - width) / 2)
                y: parent.topPadding + (parent.horizontal ? (parent.availableHeight - height) / 2 : parent.visualPosition * (parent.availableHeight - height))
                width: 24
                height: 24
                radius: 12
                color: parent.pressed ? "#f0f0f0" : "#ffffff"
                border.color: "#cccccc"

                Rectangle {
                    anchors.centerIn: parent
                    width: 8
                    height: 8
                    radius: 4
                    color: "#21be2b"
                }
            }
        }

        Text {
            text: "当前值: " + control.value
            font.pointSize: 11
        }

        Item { Layout.fillHeight: true }
    }
}
