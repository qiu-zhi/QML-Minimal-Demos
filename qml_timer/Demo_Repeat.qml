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
            title: "重复触发"
            description: "设置 repeat: true，Timer 会按 interval 周期性触发 onTriggered 信号"
        }

        Button {
            text: timer.running ? "停止计时" : "开始计时"
            onClicked: {
                if (timer.running) {
                    timer.stop()
                } else {
                    count = 0
                    timer.start()
                }
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "计数: " + count
            font.pointSize: 11
        }

        Timer {
            id: timer
            interval: 200
            repeat: true // 设置为周期性触发
            onTriggered: count++
        }
    }
}
