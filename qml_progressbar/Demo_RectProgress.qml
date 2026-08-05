import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义进度条（矩形）"
            description: "用 Rectangle 自绘进度条外观与百分比文字，拖动 Slider 时进度条平滑动画跟随"
        }

        Rectangle {
            id: control
            Layout.fillWidth: true
            height: 24

            property int minimum: 0
            property int maximum: 100
            property int value: slider.value

            border.color: "#ccc"
            radius: height / 2
            clip: true

            Rectangle {
                width: ((control.width * (control.value - control.minimum)) / (control.maximum - control.minimum) - 6)
                height: parent.height
                Behavior on width { SmoothedAnimation { velocity: 1200 } }

                anchors { left: parent.left; top: parent.top; bottom: parent.bottom; margins: 3 }
                radius: height / 2
                color: "#ff9800"
            }

            Text {
                anchors.centerIn: control
                color: "#333"
                font.bold: true
                text: Math.floor((control.value - control.minimum) / (control.maximum - control.minimum) * 100) + '%'
            }
        }

        Slider {
            id: slider
            Layout.fillWidth: true
            from: 0
            to: 100
            value: 30
            focusPolicy: Qt.NoFocus
        }

        Text {
            text: "进度值: " + control.value
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
