import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

DemoPage {
    title: "Label 背景支持"
    description: "演示 Label 的 background 属性：圆角背景、渐变背景、阴影效果"

    ColumnLayout {
        Layout.leftMargin: 20
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
            Layout.fillWidth: true
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
