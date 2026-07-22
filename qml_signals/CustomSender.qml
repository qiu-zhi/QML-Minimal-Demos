import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 信号发送端
Rectangle {
    id: root
    signal sendValue(real value)

    Layout.fillWidth: true
    Layout.preferredHeight: 120
    color: "#fff"
    border.color: "#ccc"
    border.width: 1
    radius: 6

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Text {
            text: "[CustomSender.qml] 信号发送端:"
            color: "#333"
            font.pointSize: 11
            font.bold: true
        }

        Text {
            text: "滑块值: " + slider.value.toFixed(2)
            font.pointSize: 11
            color: "#333"
        }

        Slider {
            id: slider
            Layout.fillWidth: true
            from: 0
            to: 100
            value: 50

            onValueChanged: {
                // 发送数值变化信号
                root.sendValue(value)
            }
        }
    }
}
