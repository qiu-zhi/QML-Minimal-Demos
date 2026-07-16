import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "嵌套组合"
            description: "Page + ScrollView + Pane 多层嵌套的实际应用场景"
        }

        Page {
            Layout.fillWidth: true
            Layout.fillHeight: true

            header: Rectangle {
                width: parent.width
                height: 30
                color: "#f5f5f5"
                border.color: "#ccc"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 10
                    text: "Page容器 - 多层嵌套"
                }
            }

            footer: Rectangle {
                width: parent.width
                height: 25
                border.color: "#ccc"

                Text {
                    anchors.centerIn: parent
                    font.pointSize: 9
                    text: "已创建 " + controlRepeater.count + " 个卡片"
                }
            }

            background: Rectangle {
                color: "#fff"
                border.color: "#ccc"
            }

            ScrollView {
                anchors.fill: parent
                anchors.margins: 15
                ScrollBar.horizontal.policy: ScrollBar.AsNeeded

                RowLayout {
                    spacing: 10

                    Repeater {
                        id: controlRepeater
                        model: 6
                        delegate: Pane {
                            contentWidth: 120
                            contentHeight: 120

                            background: Rectangle {
                                color: "#f5f5f5"
                                border.color: "#ccc"
                                radius: 4
                            }

                            Label {
                                anchors.centerIn: parent
                                text: "卡片 " + (index + 1)
                                font.bold: true
                                font.pointSize: 10
                            }
                        }
                    }
                }
            }
        }
    }
}
