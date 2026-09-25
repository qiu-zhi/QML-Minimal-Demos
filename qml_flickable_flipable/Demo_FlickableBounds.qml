import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Flickable 边界行为"
            description: "对比 DragAndOvershootBounds（拖拽超界回弹）与 StopAtBounds（到达边界即停止）两种边界行为"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#f9f9f9"
                radius: 4
                border.color: "#ddd"

                Column {
                    anchors.fill: parent
                    anchors.margins: 5
                    spacing: 3

                    Text {
                        text: "DragAndOvershootBounds"
                        font.pixelSize: 9
                        font.bold: true
                        color: "#e67e22"
                    }

                    Flickable {
                        id: flick1
                        width: parent.width
                        height: parent.height - 18
                        clip: true
                        contentWidth: width
                        contentHeight: col1.height
                        boundsBehavior: Flickable.DragAndOvershootBounds

                        Column {
                            id: col1
                            width: flick1.width
                            spacing: 3

                            Repeater {
                                model: 12
                                Rectangle {
                                    width: flick1.width
                                    height: 25
                                    color: index % 2 ? "#ffe0b2" : "#fff3e0"
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "项目 " + (index + 1)
                                        font.pixelSize: 10
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#f9f9f9"
                radius: 4
                border.color: "#ddd"

                Column {
                    anchors.fill: parent
                    anchors.margins: 5
                    spacing: 3

                    Text {
                        text: "StopAtBounds"
                        font.pixelSize: 9
                        font.bold: true
                        color: "#27ae60"
                    }

                    Flickable {
                        id: flick2
                        width: parent.width
                        height: parent.height - 18
                        clip: true
                        contentWidth: width
                        contentHeight: col2.height
                        boundsBehavior: Flickable.StopAtBounds

                        Column {
                            id: col2
                            width: flick2.width
                            spacing: 3

                            Repeater {
                                model: 12
                                Rectangle {
                                    width: flick2.width
                                    height: 25
                                    color: index % 2 ? "#c8e6c9" : "#e8f5e9"
                                    radius: 2

                                    Text {
                                        anchors.centerIn: parent
                                        text: "项目 " + (index + 1)
                                        font.pixelSize: 10
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Text {
            text: "左侧可拖拽超出边界回弹，右侧到达边界即停止"
            font.pointSize: 10
            color: "#666"
        }
    }
}
