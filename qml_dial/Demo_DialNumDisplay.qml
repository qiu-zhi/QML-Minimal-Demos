import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "带数值显示的 Dial"
            description: "在 Dial 中心叠加数值显示框，实时反映当前值"
        }

        Dial {
            id: control
            Layout.alignment: Qt.AlignHCenter
            width: 140
            height: 140
            from: 0
            to: 100

            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.3
                height: 30
                radius: 4
                color: "#f0f0f0"
                border.color: "#ccc"

                Text {
                    anchors.centerIn: parent
                    text: control.value.toFixed(0)
                    font.bold: true
                    font.pixelSize: 14
                }
            }
        }

        Text {
            text: "当前值: " + control.value.toFixed(0)
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 10
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
