import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 字体自适应"
        }

        Text {
            text: "演示 fontSizeMode 属性：Fit（双向适应）、HorizontalFit（水平适应）、VerticalFit（垂直适应）"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
            width: parent.width - 40
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Rectangle {
                width: 200
                height: 50
                color: "#e8f5e9"
                border.color: "#66bb6a"

                Text {
                    anchors.fill: parent
                    text: "Fit"
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 10
                    font.pixelSize: 72
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                width: 200
                height: 50
                color: "#fff3e0"
                border.color: "#ffb74d"

                Text {
                    anchors.fill: parent
                    text: "HorizontalFit"
                    fontSizeMode: Text.HorizontalFit
                    font.pixelSize: 72
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                width: 200
                height: 50
                color: "#e3f2fd"
                border.color: "#42a5f5"

                Text {
                    anchors.fill: parent
                    text: "VerticalFit"
                    fontSizeMode: Text.VerticalFit
                    font.pixelSize: 72
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "fontSizeMode: FixedSize|HorizontalFit|VerticalFit|Fit"
                font.pointSize: 9
                color: "#666"
                wrapMode: Text.WordWrap
                width: 200
            }
        }
    }
}
