import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: demoRoot
    // 桥接 SwipeView 当前页，便于宿主读取 Page.title（Page 自身不渲染标题）
    property var currentPage: swipeView.currentItem

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Page 与 SwipeView"
            description: "SwipeView 联动 PageIndicator 实现滑动切换；Page.title 自身不渲染，由上方 Label 读取显示"
        }

        // Page 不负责绘制 title，标题由宿主（这里是 Label）读取 currentPage.title 显示
        Label {
            text: demoRoot.currentPage ? demoRoot.currentPage.title : ""
            font.pointSize: 13
            font.bold: true
            color: "#1296FF"
            Layout.alignment: Qt.AlignHCenter
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            Page {
                title: "首页"
                background: Rectangle { color: "#3498db" }
                Label {
                    anchors.centerIn: parent
                    text: "首页内容"
                    color: "#fff"
                    font.pointSize: 16
                }
            }

            Page {
                title: "发现"
                background: Rectangle { color: "#e74c3c" }
                Label {
                    anchors.centerIn: parent
                    text: "发现内容"
                    color: "#fff"
                    font.pointSize: 16
                }
            }

            Page {
                title: "消息"
                background: Rectangle { color: "#2ecc71" }
                Label {
                    anchors.centerIn: parent
                    text: "消息内容"
                    color: "#fff"
                    font.pointSize: 16
                }
            }
        }

        PageIndicator {
            count: swipeView.count
            currentIndex: swipeView.currentIndex
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
