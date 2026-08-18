import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "多按键检测"
            description: "通过 mouse.button 区分左键、右键和中键，acceptedButtons 控制接收的按键"
        }

        Rectangle {
            id: box
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#EAF4FF"
            border.color: "#1296FF"
            border.width: 2

            property int leftCount: 0
            property int rightCount: 0
            property int middleCount: 0

            Column {
                anchors.centerIn: parent
                spacing: 16

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "在此区域点击鼠标按键"
                    font.pointSize: 13
                    color: "#666"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "左键: " + box.leftCount + "  右键: " + box.rightCount + "  中键: " + box.middleCount
                    font.pointSize: 16
                    font.bold: true
                    color: "#1296FF"
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                        box.leftCount++
                        box.color = "#BCE6FF"
                    } else if (mouse.button === Qt.RightButton) {
                        box.rightCount++
                        box.color = "#FFD4D4"
                    } else if (mouse.button === Qt.MiddleButton) {
                        box.middleCount++
                        box.color = "#D4FFD4"
                    }
                    colorResetTimer.start()
                }
            }

            Timer {
                id: colorResetTimer
                interval: 300
                onTriggered: box.color = "#EAF4FF"
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "提示：右键和中键点击需要设置 acceptedButtons"
            font.pointSize: 10
            color: "#999"
        }
    }
}
