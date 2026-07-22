import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text Markdown文本"
            description: "演示 Markdown 格式支持：粗体、斜体、删除线、无序列表、有序列表"
        }

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

        Item { Layout.fillHeight: true }

        Note {
            text: "- 支持CommonMark + GitHub扩展\n- 表格、任务列表等"
        }
    }
}
