import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        id: root
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        property var titles: ["页面1", "页面2", "页面3"]

        TitleSeparator {
            title: "StackLayout 堆叠布局"
            description: "同一时间只显示一个子项，配合 TabBar 实现页面切换和标签页"
        }

        // 自定义标签按钮
        TabBar {
            id: tabBar
            Layout.fillWidth: true

            Repeater {
                model: root.titles
                TabButton {
                    width: 100
                    height: 32

                    background: Rectangle {
                        border.color: tabBar.currentIndex === index ? "#1296FF" : "#ccc"
                        border.width: 1
                        radius: 4

                        color: {
                            if (tabBar.currentIndex === index) return "#E3F2FD"
                            else if (pressed) return "#e5e5e5"
                            else if (hovered) return "#f5f5f5"
                            return "#f0f0f0"
                        }
                    }

                    contentItem: Text {
                        text: modelData
                        font.pointSize: 10
                        font.bold: true
                        color: tabBar.currentIndex === index ? "#1296FF" : "#555"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: stackLayout.currentIndex = index
                }
            }
        }

        // 堆叠布局
        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true

            Repeater {
                model: root.titles
                Rectangle {
                    color: "#f8f9fa"
                    border.color: "#e0e0e0"
                    border.width: 1
                    radius: 6

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        font.pointSize: 18
                        font.bold: true
                        color: "#1296FF"
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#eee"
        }

        // 说明
        Note {
            text: "**说明：**\n- StackLayout: 堆叠布局，同一时间只显示一个子项\n- 常配合 TabBar / ButtonGroup 实现标签页切换"
        }
    }
}
