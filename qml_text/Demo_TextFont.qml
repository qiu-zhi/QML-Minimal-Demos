import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 字体属性"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Text {
                text: "字体系列: Arial"
                font.family: "Arial"
                font.pointSize: 12
            }

            Text {
                text: "字体系列: Courier New"
                font.family: "Courier New"
                font.pointSize: 12
            }

            Text {
                text: "字体大小: 18pt"
                font.pointSize: 18
            }

            Text {
                text: "字体粗细: Bold (700)"
                font.pointSize: 12
                font.weight: Font.Bold
            }

            Text {
                text: "字母间距: 5px"
                font.pointSize: 12
                font.letterSpacing: 5
            }

            Text {
                text: "单词间距: 10px"
                font.pointSize: 12
                font.wordSpacing: 10
            }
        }
    }
}
