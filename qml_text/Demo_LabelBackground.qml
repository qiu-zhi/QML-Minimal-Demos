import QtQuick
import QtQuick.Controls

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Label 背景支持"
        }

        Text {
            text: "演示 Label 的 background 属性：圆角背景、渐变背景、阴影效果"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
            width: parent.width - 40
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Label {
                text: "圆角背景"
                padding: 8
                background: Rectangle {
                    color: "#e3f2fd"
                    border.color: "#1976D2"
                    border.width: 1
                    radius: 6
                }
            }

            Label {
                text: "渐变背景"
                padding: 8
                background: Rectangle {
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#E91E63" }
                        GradientStop { position: 1.0; color: "#9C27B0" }
                    }
                    radius: 6
                }
                color: "white"
            }

            Label {
                text: "阴影效果"
                padding: 10
                background: Rectangle {
                    color: "white"
                    border.color: "#ddd"
                    radius: 4
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -2
                        color: "transparent"
                        border.color: "#e0e0e0"
                        radius: 6
                        z: -1
                    }
                }
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "- background: Item"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- 自动跟随控件大小"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
