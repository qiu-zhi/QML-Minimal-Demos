import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "长按检测"
            description: "监听 pressAndHold 信号，按住 800ms 后触发长按效果"
        }

        Rectangle {
            id: box
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#EAF4FF"
            border.color: "#1296FF"
            border.width: 2

            property int holdCount: 0

            // 长按进度条
            Rectangle {
                id: progressBar
                x: 10
                y: box.height - 16
                height: 6
                radius: 3
                color: "#1296FF"
                opacity: mouseArea.pressed ? 1.0 : 0.0
                width: 0

                NumberAnimation on width {
                    id: fillAnim
                    duration: 800
                    easing.type: Easing.Linear
                    to: box.width - 20
                    running: mouseArea.pressed
                }
            }

            Text {
                anchors.centerIn: parent
                text: mouseArea.pressed ? "按住中..." : "按住此处\n（长按 800ms）"
                font.pointSize: 14
                color: "#1296FF"
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                pressAndHoldInterval: 800
                onPressed: box.color = "#D4E8FF"
                onPressAndHold: {
                    box.holdCount++
                    statusText.text = "长按触发！触发次数: " + box.holdCount
                    flashAnim.start()
                }
                onReleased: {
                    progressBar.width = 0
                    box.color = "#EAF4FF"
                }
            }

            SequentialAnimation {
                id: flashAnim
                ColorAnimation { target: box; property: "color"; to: "#1296FF"; duration: 100 }
                ColorAnimation { target: box; property: "color"; to: "#EAF4FF"; duration: 200 }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            text: "等待长按操作..."
            font.pointSize: 12
            color: "#999"
        }
    }
}
