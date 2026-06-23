import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 富文本 (HTML)"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

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
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "支持标签: b, i, u, s, font, h1-h6, p, br, a, img"
                font.pointSize: 9
                color: "#666"
                wrapMode: Text.WordWrap
                width: 200
            }
        }
    }
}
