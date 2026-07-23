import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "富文本 Tooltip"
            description: "在 contentItem 中使用布局、图标与多行文本，并为背景添加阴影效果"
        }

        RowLayout {
            Layout.preferredHeight: 120
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Rectangle {
                Layout.preferredWidth: 120
                Layout.preferredHeight: 40
                color: "lightpink"
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: "富文本 Tooltip"
                }

                ToolTip {
                    id: richTooltip
                    delay: 500
                    timeout: 5000
                    visible: richMA.hovered

                    contentItem: ColumnLayout {
                        Text {
                            text: "富文本提示"
                            font.bold: true
                            color: "#E91E63"
                        }
                        Image {
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 32
                            source: "qrc:/qt/qml/qml_tooltip/images/info.svg"
                        }
                        Text {
                            text: "包含图标和多行文本的tooltip"
                            color: "#333333"
                        }
                    }

                    background: Rectangle {
                        color: "#FFFFFF"
                        radius: 8
                        border.color: "#E0E0E0"
                        border.width: 1

                        layer.enabled: true
                        layer.effect: DropShadow {
                            transparentBorder: true
                            horizontalOffset: 2
                            verticalOffset: 2
                            radius: 8.0
                            samples: 17
                            color: "#80000000"
                        }
                    }
                }

                HoverHandler {
                    id: richMA
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
