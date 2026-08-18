import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 18

        TitleSeparator {
            title: "单轴约束拖拽"
            description: "通过 drag.axis 限制仅水平 (XAxis)、仅垂直 (YAxis) 或双轴 (XAndYAxis) 方向的拖动，常见于滑块与刻度尺"
        }

        // 水平拖拽轨道
        Rectangle {
            id: hTrack
            Layout.alignment: Qt.AlignHCenter
            width: 480
            height: 70
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1

            // 轨道中线
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                x: 12
                width: parent.width - 24
                height: 2
                color: "#E0E0E0"
            }

            Text {
                x: 12
                y: 8
                text: "XAxis：仅水平拖拽"
                font.pointSize: 10
                color: "#999"
            }

            Rectangle {
                id: hKnob
                width: 50
                height: 50
                radius: 25
                color: hMouse.pressed ? "#0E7BD9" : "#1296FF"
                y: (hTrack.height - height) / 2
                x: 12

                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "↔"
                    color: "white"
                    font.pointSize: 20
                    font.bold: true
                }

                MouseArea {
                    id: hMouse
                    anchors.fill: parent
                    drag.target: hKnob
                    drag.axis: Drag.XAxis
                    drag.minimumX: 12
                    drag.maximumX: hTrack.width - hKnob.width - 12
                    cursorShape: Qt.SizeHorCursor
                }
            }

            Text {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 4
                text: "x = " + Math.round(hKnob.x)
                font.pointSize: 11
                color: "#1296FF"
            }
        }

        // 垂直拖拽轨道
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 30

            Rectangle {
                id: vTrack
                width: 70
                height: 240
                radius: 8
                color: "#FAFAFA"
                border.color: "#ddd"
                border.width: 1

                // 轨道中线
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 12
                    width: 2
                    height: parent.height - 24
                    color: "#E0E0E0"
                }

                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Y"
                    font.pointSize: 10
                    color: "#999"
                }

                Rectangle {
                    id: vKnob
                    width: 50
                    height: 50
                    radius: 25
                    color: vMouse.pressed ? "#0E7BD9" : "#1296FF"
                    x: (vTrack.width - width) / 2
                    y: 12

                    Behavior on color { ColorAnimation { duration: 120 } }

                    Text {
                        anchors.centerIn: parent
                        text: "↕"
                        color: "white"
                        font.pointSize: 20
                        font.bold: true
                    }

                    MouseArea {
                        id: vMouse
                        anchors.fill: parent
                        drag.target: vKnob
                        drag.axis: Drag.YAxis
                        drag.minimumY: 12
                        drag.maximumY: vTrack.height - vKnob.height - 12
                        cursorShape: Qt.SizeVerCursor
                    }
                }
            }

            ColumnLayout {
                spacing: 10
                Layout.alignment: Qt.AlignVCenter

                Text {
                    text: "YAxis：仅垂直拖拽"
                    font.pointSize: 12
                    color: "#333"
                    font.bold: true
                }
                Text {
                    text: "y = " + Math.round(vKnob.y)
                    font.pointSize: 13
                    color: "#1296FF"
                    font.bold: true
                }
                Text {
                    text: "drag.axis 取值：\n· Drag.XAxis  仅水平\n· Drag.YAxis  仅垂直\n· Drag.XAndYAxis  双轴\n· Drag.None  禁用拖拽"
                    font.pointSize: 10
                    color: "#666"
                    wrapMode: Text.Wrap
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
