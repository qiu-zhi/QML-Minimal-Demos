import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 右侧抽屉：功能设置（edge: Qt.RightEdge），条目带开关
Drawer {
    id: root
    // 显式挂到窗口 overlay，抽屉的滑动边界就是窗口边缘
    parent: Overlay.overlay
    width: 280
    height: Overlay.overlay.height
    edge: Qt.RightEdge
    modal: true

    background: Rectangle {
        color: "#e6e6e6"
        border.color: "#ccc"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Text {
            text: "功能设置"
            font.pointSize: 13
            font.bold: true
            color: "#333"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: "#ccc"
        }

        CustomModel { id: settingsModel }

        Repeater {
            model: settingsModel

            Rectangle {
                id: settingItem
                required property string cmIcon
                required property string cmText
                required property string cmColor

                Layout.fillWidth: true
                Layout.preferredHeight: 50
                color: "#f5f5f5"
                radius: 6

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Rectangle {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        radius: 15
                        color: settingItem.cmColor

                        Image {
                            source: settingItem.cmIcon
                            sourceSize.width: 16
                            sourceSize.height: 16
                            anchors.centerIn: parent
                        }
                    }

                    Label {
                        text: settingItem.cmText
                        font.pointSize: 11
                        color: "#333"
                        Layout.fillWidth: true
                    }

                    Switch {
                        checked: true
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
