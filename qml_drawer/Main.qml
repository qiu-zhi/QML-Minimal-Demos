import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "Drawer Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Text {
            text: root.title
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // 内容区：四个方向的抽屉集中在同一页
    Demo_DrawerEdges {
        anchors.fill: parent
    }
}
