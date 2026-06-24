import QtQuick
import QtQuick.Controls

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Label 内边距控制"
        }

        Text {
            text: "演示 Label 的 padding 属性：统一内边距、top/bottom/left/rightPadding 独立控制"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
            width: parent.width - 40
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Label {
                text: "默认内边距"
                padding: 10
                background: Rectangle { color: "#e8f5e9"; border.color: "#66bb6a" }
            }

            Label {
                text: "自定义内边距"
                padding: 10
                topPadding: 20
                bottomPadding: 20
                leftPadding: 30
                rightPadding: 30
                background: Rectangle { color: "#fff3e0"; border.color: "#ffb74d" }
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "- padding: 统一内边距"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- topPadding/bottomPadding"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- leftPadding/rightPadding"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- inset属性 (背景相关)"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
