import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 可点击文本"
            description: "演示交互式文本：点击变色、按下缩放、按钮样式、边框按钮"
        }

        // 基础点击效果 - 用布尔属性切换颜色
        Text {
            id: clickText1
            text: "点击我切换颜色"
            font.pointSize: 13
            color: toggled ? "#E91E63" : "#1976D2"

            property bool toggled: false

            MouseArea {
                anchors.fill: parent
                onClicked: clickText1.toggled = !clickText1.toggled
            }
        }

        // 带按下效果
        Text {
            id: clickText2
            text: "按下缩放效果"
            font.pointSize: 13
            color: pressed ? "#E91E63" : "#333"

            property bool pressed: false

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    clickText2.pressed = true
                    clickText2.scale = 0.9
                }
                onReleased: {
                    clickText2.pressed = false
                    clickText2.scale = 1.0
                }
            }

            Behavior on scale {
                NumberAnimation { duration: 100 }
            }
        }

        // 按钮样式文本
        Rectangle {
            Layout.preferredWidth: 120
            Layout.preferredHeight: 36
            radius: 4
            color: buttonArea.pressed ? "#1565C0" : "#1976D2"

            Text {
                anchors.centerIn: parent
                text: "按钮样式"
                color: "white"
                font.pointSize: 12
            }

            MouseArea {
                id: buttonArea
                anchors.fill: parent
            }

            Behavior on color {
                ColorAnimation { duration: 100 }
            }
        }

        // 带边框的点击文本
        Rectangle {
            id: borderBtn
            Layout.preferredWidth: 120
            Layout.preferredHeight: 32
            radius: 16
            border.color: borderArea.pressed ? "#E91E63" : "#1976D2"
            border.width: 2
            color: borderArea.pressed ? "#fce4ec" : "white"

            Text {
                anchors.centerIn: parent
                text: "边框按钮"
                color: borderBtn.border.color
                font.pointSize: 12
            }

            MouseArea {
                id: borderArea
                anchors.fill: parent
            }

            Behavior on color {
                ColorAnimation { duration: 100 }
            }
        }

        Item { Layout.fillHeight: true }

        Note {
            text: "- 实现: MouseArea + Behavior动画"
        }
    }
}
