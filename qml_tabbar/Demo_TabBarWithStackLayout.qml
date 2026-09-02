import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "TabBar 与 StackLayout"
            description: "TabBar 切换标签时联动 StackLayout 显示不同页面"
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            TabButton {
                text: "页面1"
                width: implicitWidth
            }
            TabButton {
                text: "页面2"
                width: implicitWidth
            }
            TabButton {
                text: "页面3"
                width: implicitWidth
            }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabBar.currentIndex

            Rectangle {
                color: "#3498db"
                Text {
                    anchors.centerIn: parent
                    text: "页面 1"
                    color: "#fff"
                    font.pointSize: 20
                    font.bold: true
                }
            }

            Rectangle {
                color: "#e74c3c"
                Text {
                    anchors.centerIn: parent
                    text: "页面 2"
                    color: "#fff"
                    font.pointSize: 20
                    font.bold: true
                }
            }

            Rectangle {
                color: "#2ecc71"
                Text {
                    anchors.centerIn: parent
                    text: "页面 3"
                    color: "#fff"
                    font.pointSize: 20
                    font.bold: true
                }
            }
        }

        Text {
            text: "当前索引: " + tabBar.currentIndex + " / 总页数: " + stackLayout.count
            font.pointSize: 11
            color: "#333"
        }
    }
}
