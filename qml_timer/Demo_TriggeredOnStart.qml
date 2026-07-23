import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    property int count: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "立即触发"
            description: "设置 triggeredOnStart: true，Timer 启动时立即触发一次 onTriggered 信号"
        }

        CheckBox {
            text: "启动立即触发"
            checked: false
            checkable: true
            onCheckedChanged: {
                if (checked) {
                    count = 0
                    timer.start()
                } else {
                    timer.stop()
                }
            }
        }

        Text {
            id: message
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "count: " + count
            font.pointSize: 11
        }

        Timer {
            id: timer
            interval: 200
            repeat: true
            triggeredOnStart: true // 启动立即触发
            onTriggered: {
                count++
            }
        }
    }
}
