import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本对齐"
        }

        Text {
            text: "演示文本对齐方式：horizontalAlignment（水平）和 verticalAlignment（垂直）"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
            width: parent.width - 40
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Text {
                width: 200
                text: "左对齐 (默认)"
                horizontalAlignment: Text.AlignLeft
                font.pointSize: 11
                Rectangle { width: parent.width; height: 1; color: "#ccc"; anchors.bottom: parent.bottom }
            }

            Text {
                width: 200
                text: "居中对齐"
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 11
                Rectangle { width: parent.width; height: 1; color: "#ccc"; anchors.bottom: parent.bottom }
            }

            Text {
                width: 200
                text: "右对齐"
                horizontalAlignment: Text.AlignRight
                font.pointSize: 11
                Rectangle { width: parent.width; height: 1; color: "#ccc"; anchors.bottom: parent.bottom }
            }

            Rectangle {
                width: 200
                height: 40
                color: "#f5f5f5"
                border.color: "#ddd"

                Text {
                    anchors.fill: parent
                    text: "垂直居中"
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 11
                }
            }

            Rectangle {
                width: 200
                height: 40
                color: "#f5f5f5"
                border.color: "#ddd"

                Text {
                    anchors.fill: parent
                    text: "水平+垂直居中"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 11
                }
            }
        }
    }
}
