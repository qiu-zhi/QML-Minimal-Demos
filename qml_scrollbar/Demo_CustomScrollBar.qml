import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义滚动条样式"
            description: "通过自定义 background 和 contentItem 实现个性化的 ScrollBar 外观"
        }

        Flickable {
            id: flickable
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true  // 防止内容超出边界

            contentWidth: contentRect.width
            contentHeight: contentRect.height

            ScrollBar.vertical: ScrollBar {
                id: vBar
                width: hovered || pressed ? 14 : 10
                policy: ScrollBar.AsNeeded

                Behavior on width {
                    NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                }

                // 轨道：内嵌浅槽
                background: Rectangle {
                    implicitWidth: 10
                    radius: width / 2
                    color: "#1296FF"
                    opacity: 0.10
                    border.width: 1
                    border.color: "#2E1296FF"
                }

                // 滑块：胶囊形 + 主题色渐变，悬停时加宽提亮
                contentItem: Rectangle {
                    implicitWidth: 8
                    radius: width / 2
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: vBar.pressed ? "#0A6FB8" : vBar.hovered ? "#4DB3FF" : "#8FCEFF"
                        }
                        GradientStop {
                            position: 1.0
                            color: vBar.pressed ? "#0A7ACC" : vBar.hovered ? "#1296FF" : "#5FB9FF"
                        }
                    }
                    opacity: vBar.pressed ? 1.0 : vBar.hovered ? 0.95 : 0.8
                    Behavior on opacity {
                        NumberAnimation { duration: 150 }
                    }
                }
            }

            Rectangle {
                id: contentRect
                width: 500
                height: 500
                color: "#3498db"
                Text {
                    text: "Scrollable Content"
                    anchors.centerIn: parent
                    font.pointSize: 20
                    color: "#fff"
                }
            }
        }
    }
}
