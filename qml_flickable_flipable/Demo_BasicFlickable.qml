import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Flickable 基础用法"
            description: "可滚动浏览超出视口的内容，配合 ScrollBar 实现列表滚动"
        }

        Flickable {
            id: flick
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentWidth: width
            contentHeight: column.height

            Column {
                id: column
                width: flick.width
                spacing: 5

                Repeater {
                    model: 15
                    Rectangle {
                        width: flick.width
                        height: 35
                        color: index % 2 ? "#e8f4f8" : "#d4eef6"
                        radius: 3

                        Text {
                            anchors.centerIn: parent
                            text: "列表项 " + (index + 1)
                            font.pixelSize: 13
                        }
                    }
                }
            }

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }
        }

        Text {
            text: "contentY: " + Math.round(flick.contentY)
            font.pointSize: 10
            color: "#666"
        }
    }
}
