import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "TabBar 与 SwipeView 联动"
            description: "点击标签或滑动页面均可切换，实现双向联动"
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            currentIndex: swipeView.currentIndex

            Repeater {
                model: ["首页", "发现", "消息", "我的"]
                TabButton {
                    text: modelData
                    ToolTip.visible: hovered
                    ToolTip.text: "索引: " + TabBar.index
                }
            }
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            // 使用 currentIndex 进行双向绑定
            currentIndex: tabBar.currentIndex

            Repeater {
                model: ["#3498db", "#e74c3c", "#2ecc71", "#f39c12"]
                Rectangle {
                    color: modelData
                    Text {
                        anchors.centerIn: parent
                        text: "页面 " + (index + 1)
                        color: "#fff"
                        font.pointSize: 18
                        font.bold: true
                    }
                }
            }
        }

        Text {
            text: "当前索引: " + swipeView.currentIndex + " / 总页数: " + swipeView.count
            font.pointSize: 11
            color: "#333"
        }
    }
}
