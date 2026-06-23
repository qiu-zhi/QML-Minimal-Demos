import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text Markdown文本"
        }

        Text {
            text: "演示 Markdown 格式支持：粗体、斜体、删除线、无序列表、有序列表"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
            width: parent.width - 40
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Text {
                text: "**粗体** *斜体* ~~删除线~~"
                textFormat: Text.MarkdownText
                font.pointSize: 12
            }

            Text {
                width: 200
                text: "- 列表项1\n- 列表项2\n- 列表项3"
                textFormat: Text.MarkdownText
                font.pointSize: 11
                wrapMode: Text.WordWrap
            }

            Text {
                width: 200
                text: "1. 有序项1\n2. 有序项2\n3. 有序项3"
                textFormat: Text.MarkdownText
                font.pointSize: 11
                wrapMode: Text.WordWrap
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "支持CommonMark + GitHub扩展"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "表格、任务列表等"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
