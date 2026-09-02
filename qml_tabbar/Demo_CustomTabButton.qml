import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义 TabButton 样式"
            description: "自定义 contentItem 与 background 实现圆角背景和颜色动画"
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            background: Rectangle {
                color: "#f5f5f5"
                radius: 4
            }

            TabButton {
                text: "首页"
                width: implicitWidth + 20

                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 14
                    color: parent.checked ? "#fff" : "#666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    implicitWidth: 60
                    implicitHeight: 36
                    color: parent.checked ? "#3498db" : "transparent"
                    radius: 4

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
            }

            TabButton {
                text: "发现"
                width: implicitWidth + 20

                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 14
                    color: parent.checked ? "#fff" : "#666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    implicitWidth: 60
                    implicitHeight: 36
                    color: parent.checked ? "#3498db" : "transparent"
                    radius: 4

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
            }

            TabButton {
                text: "我的"
                width: implicitWidth + 20

                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 14
                    color: parent.checked ? "#fff" : "#666"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    implicitWidth: 60
                    implicitHeight: 36
                    color: parent.checked ? "#3498db" : "transparent"
                    radius: 4

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Qt.rgba(0.95, 0.95, 0.95, 1)
            radius: 4

            Text {
                anchors.centerIn: parent
                text: "自定义样式：圆角背景 + 颜色动画"
                font.pointSize: 11
                color: "#666"
            }
        }
    }
}
