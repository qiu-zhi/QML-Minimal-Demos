import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    QtObject {
        id: drawerNav
        property int currentIndex: 0
        property bool isOpen: false
        property var pages: [
            { name: "首页", color: "#3498db" },
            { name: "消息", color: "#9b59b6" },
            { name: "设置", color: "#e67e22" }
        ]
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "抽屉式导航"
            description: "侧滑抽屉式导航菜单，点击按钮展开，点击遮罩或菜单项关闭"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                implicitWidth: 120
                implicitHeight: 40
                text: drawerNav.isOpen ? "关闭菜单" : "打开菜单"
                onClicked: drawerNav.isOpen = !drawerNav.isOpen
            }

            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                text: "当前页面: " + drawerNav.pages[drawerNav.currentIndex].name
                font.pointSize: 10
                color: "#666"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 4
            color: drawerNav.pages[drawerNav.currentIndex].color

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }

            Text {
                anchors.centerIn: parent
                text: drawerNav.pages[drawerNav.currentIndex].name + "内容"
                color: "#fff"
                font.pointSize: 14
                font.bold: true
            }
        }
    }

    // 遮罩层：覆盖整个内容区，点击关闭抽屉
    Rectangle {
        id: drawerMask
        anchors.fill: parent
        color: "#80000000"
        visible: drawerNav.isOpen
        z: 1

        MouseArea {
            anchors.fill: parent
            onClicked: drawerNav.isOpen = false
        }
    }

    // 抽屉面板：始终位于内容区内，关闭时滑出左侧边界由容器裁剪
    Rectangle {
        id: drawerPanel
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 140
        x: drawerNav.isOpen ? 0 : -width
        color: "#34495e"
        z: 2

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5

            Text {
                text: "导航菜单"
                font.pointSize: 11
                font.bold: true
                color: "#fff"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Repeater {
                model: drawerNav.pages

                Rectangle {
                    id: menuItem
                    required property int index
                    required property var modelData

                    Layout.fillWidth: true
                    Layout.preferredHeight: 34
                    radius: 4
                    color: drawerNav.currentIndex === menuItem.index ? menuItem.modelData.color : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: menuItem.modelData.name
                        font.pointSize: 10
                        color: "#fff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            drawerNav.currentIndex = menuItem.index
                            drawerNav.isOpen = false
                        }
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
