import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "TabBar 位置"
            description: "将 TabBar 放入 Page 的 footer 自动作为底部导航栏，header 则为顶部"
        }

        Page {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // 在 Page::Header 中自动设置为 TabBar.Header，
            // 在 Page::Footer 中自动为 TabBar.Footer，
            // tabBar 不能同时设置到 header、footer 中。
            header: null
            footer: tabBar

            StackLayout {
                anchors.fill: parent
                currentIndex: tabBar.currentIndex

                Rectangle {
                    color: "#3498db"
                    Text {
                        anchors.centerIn: parent
                        text: "首页内容"
                        color: "#fff"
                        font.pointSize: 16
                    }
                }

                Rectangle {
                    color: "#e74c3c"
                    Text {
                        anchors.centerIn: parent
                        text: "消息内容"
                        color: "#fff"
                        font.pointSize: 16
                    }
                }

                Rectangle {
                    color: "#2ecc71"
                    Text {
                        anchors.centerIn: parent
                        text: "我的内容"
                        color: "#fff"
                        font.pointSize: 16
                    }
                }
            }

            TabBar {
                id: tabBar
                TabButton { text: "首页" }
                TabButton { text: "消息" }
                TabButton { text: "我的" }
            }
        }

        Text {
            text: "当前位置: " + (tabBar.position === TabBar.Header ? "顶部" : "底部")
            font.pointSize: 11
            color: "#666"
        }
    }
}
