import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "多 Dial 联动"
            description: "主 Dial 变化时同步更新从属 Dial 的值，实现联动效果"
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15

            Dial {
                id: masterDial
                width: 120
                height: 120
                from: 0
                to: 100
                value: 50

                onValueChanged: {
                    slaveDial1.value = value / 2
                    slaveDial2.value = 100 - value
                }
            }

            Dial {
                id: slaveDial1
                width: 110
                height: 110
                from: 0
                to: 50
                enabled: false
            }

            Dial {
                id: slaveDial2
                width: 110
                height: 110
                from: 0
                to: 100
                enabled: false
            }
        }

        Text {
            text: `master: ${masterDial.value.toFixed(0)}  slave1: ${slaveDial1.value.toFixed(0)}  slave2: ${slaveDial2.value.toFixed(0)}`
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 10
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
