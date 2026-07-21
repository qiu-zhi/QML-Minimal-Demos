import QtQuick
import QtQuick.Layouts

DemoPage {
    title: "Text Markdown文本"
    description: "演示 Markdown 格式支持：粗体、斜体、删除线、无序列表、有序列表"

    Text {
        text: "**粗体** *斜体* ~~删除线~~"
        textFormat: Text.MarkdownText
        font.pointSize: 12
    }

    Text {
        Layout.preferredWidth: 200
        text: "- 列表项1\n- 列表项2\n- 列表项3"
        textFormat: Text.MarkdownText
        font.pointSize: 11
        wrapMode: Text.WordWrap
    }

    Text {
        Layout.preferredWidth: 200
        text: "1. 有序项1\n2. 有序项2\n3. 有序项3"
        textFormat: Text.MarkdownText
        font.pointSize: 11
        wrapMode: Text.WordWrap
    }

    Rectangle {
        Layout.fillWidth: true
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
