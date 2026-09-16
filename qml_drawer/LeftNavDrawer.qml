import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 左侧抽屉：主导航菜单（edge: Qt.LeftEdge）
// 选中菜单项后通过 itemSelected(text) 通知外部，自身用 selectedItem 高亮当前项
Drawer {
    id: root
    // 显式挂到窗口 overlay，抽屉的滑动边界就是窗口边缘
    parent: Overlay.overlay
    width: 260
    height: Overlay.overlay.height
    edge: Qt.LeftEdge
    modal: true

    // 当前选中的菜单项（高亮依据）
    property string selectedItem: "首页"
    // 点击菜单项时向外通知
    signal itemSelected(string text)

    background: Rectangle {
        color: "#2c3e50"

        // 抽屉外侧的收起把手
        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.right
            width: 20
            height: 60
            color: "#34495e"

            Text {
                anchors.centerIn: parent
                text: "收\n起"
                wrapMode: Text.Wrap
                font.pointSize: 9
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.close()
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        // 用户信息区域
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "transparent"

            RowLayout {
                anchors.fill: parent
                spacing: 10

                Rectangle {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    radius: 25
                    color: "#3498db"

                    Label {
                        text: "U"
                        font.pointSize: 16
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5

                    Label {
                        text: "用户名"
                        font.pointSize: 9
                        color: "white"
                        font.bold: true
                    }

                    Label {
                        text: "user@example.com"
                        font.pointSize: 9
                        color: "#bdc3c7"
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: "#34495e"
        }

        CustomModel { id: navModel }

        Repeater {
            model: navModel

            Rectangle {
                id: navItem
                required property string cmIcon
                required property string cmText
                required property string cmColor

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: navItem.cmText === root.selectedItem ? "#34495e" : "transparent"
                radius: 8

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 20

                    Rectangle {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        radius: 15
                        color: navItem.cmColor

                        Image {
                            source: navItem.cmIcon
                            sourceSize.width: 16
                            sourceSize.height: 16
                            anchors.centerIn: parent
                        }
                    }

                    Label {
                        text: navItem.cmText
                        font.pointSize: 11
                        color: "white"
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        Layout.preferredWidth: 8
                        Layout.preferredHeight: 8
                        radius: 4
                        color: "#e74c3c"
                        visible: navItem.cmText === "消息通知"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.selectedItem = navItem.cmText
                        root.itemSelected(navItem.cmText)
                        root.close()
                    }
                }

                Behavior on color {
                    ColorAnimation { duration: 200 }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
