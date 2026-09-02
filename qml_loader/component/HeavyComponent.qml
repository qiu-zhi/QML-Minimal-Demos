import QtQuick
import QtQuick.Controls

Rectangle {
    color: "#666"
    radius: 6

    Column {
        anchors.centerIn: parent
        spacing: 15

        Text {
            text: "耗时组件已加载完成"
            font.pixelSize: 16
            color: "#fff"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            width: 50
            height: 50
            color: "#fff"
            radius: 6
            anchors.horizontalCenter: parent.horizontalCenter

            RotationAnimation on rotation {
                from: 0
                to: 360
                duration: 3000
                loops: Animation.Infinite
            }
        }
    }
}
