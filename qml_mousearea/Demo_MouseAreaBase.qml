import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础点击与悬停"
            description: "演示 MouseArea 的 clicked 信号与 containsMouse 悬停状态检测"
        }

        Rectangle {
            id: box
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: clickCount % 2 === 0 ? "#EAF4FF" : "#BCE6FF"
            border.width: mouseArea.containsMouse ? 3 : 1
            border.color: "#1296FF"

            property int clickCount: 0

            Text {
                anchors.centerIn: parent
                text: "点击我\n已点击: " + box.clickCount + " 次"
                font.pointSize: 14
                color: "#1296FF"
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: box.clickCount++
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "悬停状态: " + (mouseArea.containsMouse ? "鼠标在内" : "鼠标在外")
            font.pointSize: 12
            color: "#999"
        }
    }
}
