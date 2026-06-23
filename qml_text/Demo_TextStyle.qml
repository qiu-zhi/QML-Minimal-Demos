import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本样式"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

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
                width: 200
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
        }
    }
}
