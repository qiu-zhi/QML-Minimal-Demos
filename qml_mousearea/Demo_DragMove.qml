import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "拖拽移动"
            description: "使用 drag.target 实现元素的自由拖拽，支持拖拽范围限制"
        }

        Rectangle {
            id: canvas
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            // 可拖拽的方块
            Rectangle {
                id: dragBox
                width: 80
                height: 80
                radius: 10
                color: "#1296FF"
                x: canvas.width / 2 - 40
                y: canvas.height / 2 - 40

                Text {
                    anchors.centerIn: parent
                    text: "拖我"
                    color: "white"
                    font.bold: true
                    font.pointSize: 13
                }

                Drag.active: dragArea.drag.active
                Drag.dragType: Drag.None

                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    drag.target: dragBox
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: canvas.width - dragBox.width
                    drag.minimumY: 0
                    drag.maximumY: canvas.height - dragBox.height
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Text {
                text: "当前坐标: (" + Math.round(dragBox.x) + ", " + Math.round(dragBox.y) + ")"
                font.pointSize: 12
                color: "#999"
            }

            Button {
                text: "重置位置"
                onClicked: {
                    dragBox.x = canvas.width / 2 - 40
                    dragBox.y = canvas.height / 2 - 40
                }
            }
        }
    }
}
