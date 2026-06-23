import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 基础用法"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Text {
                text: "普通文本 - Hello World!"
                font.pointSize: 12
            }

            Text {
                text: "带颜色文本"
                font.pointSize: 12
                color: "#E91E63"
            }

            Text {
                text: "粗体文本"
                font.pointSize: 12
                font.bold: true
            }

            Text {
                text: "斜体文本"
                font.pointSize: 12
                font.italic: true
            }

            Text {
                text: "下划线文本"
                font.pointSize: 12
                font.underline: true
            }

            Text {
                text: "删除线文本"
                font.pointSize: 12
                font.strikeout: true
            }
        }
    }
}
