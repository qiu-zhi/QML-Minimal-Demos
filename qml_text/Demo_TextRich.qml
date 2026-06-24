import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 富文本 (HTML)"
            description: "演示 HTML 富文本格式：粗体、斜体、下划线、删除线、颜色、字号、标题段落"
        }

        Text {
            text: "<b>粗体</b> <i>斜体</i> <u>下划线</u> <s>删除线</s>"
            textFormat: Text.RichText
            font.pointSize: 12
        }

        Text {
            text: "<font color='red'>红色</font> <font color='green'>绿色</font> <font color='blue'>蓝色</font>"
            textFormat: Text.RichText
            font.pointSize: 12
        }

        Text {
            text: "<font size='5'>大号</font> <font size='2'>小号</font>"
            textFormat: Text.RichText
            font.pointSize: 12
        }

        Text {
            text: "<h4>标题</h4><p>段落文本</p>"
            textFormat: Text.RichText
            font.pointSize: 10
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#eee"
        }

        Text {
            text: "支持标签: b, i, u, s, font, h1-h6, p, br, a, img"
            font.pointSize: 9
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
