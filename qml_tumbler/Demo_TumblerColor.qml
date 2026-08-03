import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "颜色选择器"
            description: "Tumbler 配合自定义 delegate 实现颜色滚轮选择"
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 30

            Tumbler {
                id: colorTumbler
                width: 180
                height: 240
                model: ["Red", "Green", "Blue", "Yellow", "Cyan", "Magenta"]

                delegate: Rectangle {
                    width: colorTumbler.width
                    height: 40
                    color: modelData
                    border.color: "white"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: "white"
                        font.bold: true
                        font.pixelSize: 14
                    }
                }
            }

            // 右侧显示当前颜色
            Rectangle {
                width: 160
                height: 160
                anchors.verticalCenter: parent.verticalCenter
                radius: 12
                color: colorTumbler.model[colorTumbler.currentIndex]
                border.width: 2
                border.color: "#cccccc"

                Column {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "当前颜色"
                        color: "white"
                        font.pixelSize: 12
                        style: Text.Outline
                        styleColor: "#000000"
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: colorTumbler.model[colorTumbler.currentIndex]
                        color: "white"
                        font.pixelSize: 18
                        font.bold: true
                        style: Text.Outline
                        styleColor: "#000000"
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
