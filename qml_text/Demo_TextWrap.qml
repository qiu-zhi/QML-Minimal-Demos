import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本换行"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Text {
                width: 200
                text: "NoWrap: 这是一段很长的文本，默认不会换行"
                wrapMode: Text.NoWrap
                font.pointSize: 10
                Rectangle { width: parent.width; height: parent.height; color: "#fff3e0"; border.color: "#ffb74d"; z: -1 }
            }

            Text {
                width: 200
                text: "WordWrap: 这是一段很长的文本，只在单词边界处换行"
                wrapMode: Text.WordWrap
                font.pointSize: 10
                Rectangle { width: parent.width; height: parent.height; color: "#e8f5e9"; border.color: "#66bb6a"; z: -1 }
            }

            Text {
                width: 200
                text: "Wrap: 这是一段很长的文本，优先在单词边界换行，必要时在任意位置换行"
                wrapMode: Text.Wrap
                font.pointSize: 10
                Rectangle { width: parent.width; height: parent.height; color: "#e3f2fd"; border.color: "#42a5f5"; z: -1 }
            }
        }
    }
}
