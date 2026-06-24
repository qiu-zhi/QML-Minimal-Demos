import QtQuick
import QtQuick.Controls

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Label 基础用法"
        }

        Text {
            text: "演示 Label 组件基础：自动继承应用字体、自定义字体大小、颜色、粗体斜体"
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
                text: "Label - 自动继承应用字体"
            }

            Label {
                text: "自定义字体大小"
                font.pixelSize: 24
            }

            Label {
                text: "自定义颜色"
                color: "#E91E63"
            }

            Label {
                text: "粗体 + 斜体"
                font.bold: true
                font.italic: true
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "- 自动继承应用字体"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- 与应用程序样式一致"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- 适合表单、设置界面"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
