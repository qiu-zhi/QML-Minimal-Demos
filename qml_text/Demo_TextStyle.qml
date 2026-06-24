import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本样式"
            description: "演示文本样式效果：Normal（默认）、Outline（轮廓）、Raised（凸起）、Sunken（凹陷）"
        }

        Row {
            spacing: 15

            Text {
                font.pointSize: 14
                text: "Normal"
                style: Text.Normal
            }

            Text {
                font.pointSize: 14
                text: "Outline"
                style: Text.Outline
                styleColor: "red"
            }

            Text {
                font.pointSize: 14
                text: "Raised"
                style: Text.Raised
                styleColor: "#AAAAAA"
            }

            Text {
                font.pointSize: 14
                text: "Sunken"
                style: Text.Sunken
                styleColor: "#AAAAAA"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#eee"
        }

        Text {
            text: "- Normal: 默认样式"
            font.pointSize: 10
            color: "#666"
        }

        Text {
            text: "- Outline: 轮廓效果"
            font.pointSize: 10
            color: "#666"
        }

        Text {
            text: "- Raised: 凸起效果"
            font.pointSize: 10
            color: "#666"
        }

        Text {
            text: "- Sunken: 凹陷效果"
            font.pointSize: 10
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
