import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "锚点切换"
            description: "AnchorChanges 在状态里切换 Item 的锚点，它只管锚点，宽度、边距这类要另行用 PropertyChanges 改。切换时把不再使用的锚点设为 undefined，否则新旧锚点会冲突。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button { text: "左上角"; onClicked: stage.state = "topLeft" }
            Button { text: "右下角"; onClicked: stage.state = "bottomRight" }
            Button { text: "横向铺满"; onClicked: stage.state = "stretch" }
            Button { text: "居中"; onClicked: stage.state = "center" }

            Item { Layout.fillWidth: true }

            Text {
                text: "box  x=" + box.x.toFixed(0) + "  y=" + box.y.toFixed(0) + "  w=" + box.width.toFixed(0)
                color: "#666"
                font.pointSize: 10
            }
        }

        Rectangle {
            id: stage
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FFFFFF"
            border.color: "#e0e0e0"
            radius: 8
            clip: true

            Rectangle {
                id: box
                width: 140
                height: 90
                radius: 8
                color: "#1296FF"

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 20

                Text {
                    anchors.centerIn: parent
                    text: "box"
                    color: "white"
                    font.pointSize: 14
                    font.bold: true
                }
            }

            states: [
                State {
                    name: "topLeft"
                    AnchorChanges {
                        target: box
                        anchors.left: stage.left
                        anchors.top: stage.top
                        anchors.right: undefined
                        anchors.bottom: undefined
                    }
                },
                State {
                    name: "bottomRight"
                    AnchorChanges {
                        target: box
                        anchors.right: stage.right
                        anchors.bottom: stage.bottom
                        anchors.left: undefined
                        anchors.top: undefined
                    }
                },
                State {
                    name: "stretch"
                    AnchorChanges {
                        target: box
                        anchors.left: stage.left
                        anchors.top: stage.top
                        anchors.right: undefined
                        anchors.bottom: undefined
                    }
                    // 宽度交给 PropertyChanges，别用左右双锚点：
                    // 双锚点会把 width 改成计算值，退出该状态后回不到 140
                    PropertyChanges {
                        target: box
                        width: stage.width - 40
                    }
                },
                State {
                    name: "center"
                    AnchorChanges {
                        target: box
                        anchors.horizontalCenter: stage.horizontalCenter
                        anchors.verticalCenter: stage.verticalCenter
                        anchors.left: undefined
                        anchors.top: undefined
                        anchors.right: undefined
                        anchors.bottom: undefined
                    }
                }
            ]

            transitions: Transition {
                AnchorAnimation {
                    duration: 400
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}
