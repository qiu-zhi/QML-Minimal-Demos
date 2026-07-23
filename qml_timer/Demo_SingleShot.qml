import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "单次触发"
            description: "Timer 设置 interval 后调用 start()，到时间后触发一次 onTriggered 信号"
        }

        Button {
            text: "1秒后显示消息"
            onClicked: {
                timer.start()
                message.text = "计时开始..."
            }
        }

        Text {
            id: message
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pointSize: 11
        }

        Timer {
            id: timer
            interval: 1000 // 1秒
            onTriggered: message.text = "时间到"
        }
    }
}
