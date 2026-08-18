import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "点击坐标获取"
            description: "通过 mouse.x / mouse.y 获取点击位置，并在点击处绘制标记点"
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

            // 点击标记点
            Repeater {
                model: clickModel
                delegate: Rectangle {
                    x: model.x - 8
                    y: model.y - 8
                    width: 16
                    height: 16
                    radius: 8
                    color: "#1296FF"
                    opacity: 0.7

                    Text {
                        anchors.centerIn: parent
                        text: index + 1
                        color: "white"
                        font.pixelSize: 9
                        font.bold: true
                    }

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        NumberAnimation { from: 0.7; to: 0.3; duration: 1000 }
                        NumberAnimation { from: 0.3; to: 0.7; duration: 1000 }
                    }
                }
            }

            // 最新点击位置连线指示
            Text {
                id: hintText
                anchors.centerIn: parent
                text: "在区域内点击以标记位置"
                color: "#999"
                font.pointSize: 13
                visible: clickModel.count === 0
            }

            ListModel { id: clickModel }

            MouseArea {
                id: clickArea
                anchors.fill: parent
                onClicked: (mouse) => {
                    clickModel.append({ x: mouse.x, y: mouse.y })
                    if (clickModel.count > 10)
                        clickModel.remove(0)
                    coordText.text = "最近点击: (" + Math.round(mouse.x) + ", " + Math.round(mouse.y) + ")"
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Text {
                id: coordText
                text: "最近点击: (-, -)"
                font.pointSize: 12
                color: "#999"
            }

            Button {
                text: "清除标记"
                onClicked: {
                    clickModel.clear()
                    coordText.text = "最近点击: (-, -)"
                }
            }
        }
    }
}
