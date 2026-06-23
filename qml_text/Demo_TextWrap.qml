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
            spacing: 15

            Text {
                width: 200
                text: "NoWrap: This is a very long text that will not wrap by default"
                wrapMode: Text.NoWrap
                font.pointSize: 12
                Rectangle { anchors.fill: parent; color: "#fff3e0"; border.color: "#ffb74d"; z: -1}
            }

            Text {
                width: 200
                text: "WordWrap: This is a very long text that only wraps at word boundaries"
                wrapMode: Text.WordWrap
                font.pointSize: 12
                Rectangle { anchors.fill: parent; color: "#e8f5e9"; border.color: "#66bb6a"; z: -1 }
            }

            Text {
                width: 200
                text: "Wrap: This is a very long text that prefers word boundaries but can break anywhere if needed"
                wrapMode: Text.Wrap
                font.pointSize: 12
                Rectangle { anchors.fill: parent; color: "#e3f2fd"; border.color: "#42a5f5"; z: -1 }
            }
        }
    }
}
