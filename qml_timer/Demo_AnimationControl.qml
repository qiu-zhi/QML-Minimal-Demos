import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "动画控制"
            description: "使用高频率 Timer（interval 16ms）驱动属性变化，实现自定义动画效果"
        }

        Button {
            text: moveTimer.running ? "暂停动画" : "启动动画"
            onClicked: {
                if (moveTimer.running) {
                    moveTimer.stop()
                } else {
                    moveTimer.start()
                }
            }
        }

        // 动画展示区
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FAFAFA"
            border.width: 1
            border.color: "#E0E0E0"
            radius: 6
            clip: true

            Rectangle {
                id: box
                color: "#3498db"
                border.width: 1
                border.color: "#ccc"
                x: 20
                y: parent.height / 2 - height / 2
                width: 50
                height: 50

                Text {
                    anchors.centerIn: parent
                    text: "X: " + parent.x
                    color: "#fff"
                }
            }
        }

        Timer {
            id: moveTimer
            interval: 16
            repeat: true
            running: false
            onTriggered: {
                box.x += 2
                if (box.x > box.parent.width - box.width - 20) {
                    box.x = 0
                }
            }
        }
    }
}
