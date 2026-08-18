import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "单击与双击区分"
            description: "使用 Timer 延迟判定，避免双击时误触发单击逻辑"
        }

        Rectangle {
            id: box
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#EAF4FF"
            border.color: "#1296FF"
            border.width: 2

            property int singleCount: 0
            property int doubleCount: 0
            property string status: "点击或双击此区域"

            // 延迟判定计时器：超时后确认为单击
            Timer {
                id: singleClickTimer
                interval: 250
                repeat: false
                onTriggered: {
                    box.status = "单击"
                    box.color = "#BCE6FF"
                    box.singleCount++
                }
            }

            Column {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: box.status
                    font.pointSize: 20
                    font.bold: true
                    color: "#1296FF"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "单击: " + box.singleCount + " 次  双击: " + box.doubleCount + " 次"
                    font.pointSize: 12
                    color: "#666"
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: singleClickTimer.start()
                onDoubleClicked: {
                    singleClickTimer.stop()
                    box.status = "双击"
                    box.doubleCount++
                }
            }
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            text: "重置"
            onClicked: {
                box.singleCount = 0
                box.doubleCount = 0
                box.status = "点击或双击此区域"
                box.color = "#EAF4FF"
            }
        }
    }
}
