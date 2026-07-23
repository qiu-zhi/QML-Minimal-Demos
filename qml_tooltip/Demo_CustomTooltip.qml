import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义样式"
            description: "通过自定义 contentItem 与 background 定制 Tooltip 的文字与背景外观"
        }

        RowLayout {
            Layout.preferredHeight: 120
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Rectangle {
                Layout.preferredWidth: 120
                Layout.preferredHeight: 40
                color: "lightgreen"
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: "自定义样式"
                }

                ToolTip {
                    id: customTooltip
                    text: "这是一个自定义样式的tooltip"
                    delay: 500
                    timeout: 5000
                    visible: customMA.hovered

                    contentItem: Text {
                        text: customTooltip.text
                        font.bold: true
                        color: "white"
                    }

                    background: Rectangle {
                        color: "#2196F3"
                        radius: 6
                        border.color: "#1976D2"
                        border.width: 1
                    }
                }

                HoverHandler {
                    id: customMA
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
