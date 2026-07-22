import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本省略"
            description: "演示文本省略模式：ElideRight（右侧省略）、ElideLeft（左侧省略）、ElideMiddle（中间省略）、多行省略"
        }

        Text {
            Layout.preferredWidth: 250
            text: "ElideRight: 这是一段需要被省略的长文本"
            elide: Text.ElideRight
            font.pointSize: 11
            Rectangle { anchors.fill: parent; color: "#fce4ec"; border.color: "#ef9a9a"; z: -1 }
        }

        Text {
            Layout.preferredWidth: 250
            text: "ElideLeft: 这是一段需要被省略的长文本"
            elide: Text.ElideLeft
            font.pointSize: 11
            Rectangle { anchors.fill: parent; color: "#f3e5f5"; border.color: "#ce93d8"; z: -1 }
        }

        Text {
            Layout.preferredWidth: 250
            text: "ElideMiddle: 这是一段需要被省略的长文本"
            elide: Text.ElideMiddle
            font.pointSize: 11
            Rectangle { anchors.fill: parent; color: "#e0f7fa"; border.color: "#4dd0e1"; z: -1 }
        }

        Rectangle {
            Layout.preferredWidth: 250
            height: 1
            color: "#eee"
        }

        Text {
            Layout.preferredWidth: 250
            text: "多行省略: 这是一段很长的文本，用来演示maximumLineCount属性的效果。当文本超过指定行数时，会被省略。"
            maximumLineCount: 2
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            font.pointSize: 10
            Rectangle { anchors.fill: parent; color: "#e8eaf6"; border.color: "#9fa8da"; z: -1 }
        }

        Item { Layout.fillHeight: true }
    }
}
