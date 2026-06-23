import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "可选择文本 (TextEdit)"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            TextEdit {
                width: 200
                text: "选中此文本可复制"
                font.pointSize: 13
                readOnly: true
                selectByMouse: true
                selectionColor: "#1976D2"
                selectedTextColor: "white"
            }

            TextEdit {
                width: 200
                text: "另一段可选文本"
                font.pointSize: 13
                readOnly: true
                selectByMouse: true
                selectionColor: "#E91E63"
                selectedTextColor: "white"
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "- TextEdit (可编辑/可选择)"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- readOnly: true 只读模式"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- selectByMouse: 鼠标选择"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
