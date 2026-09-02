import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "TabBar 基础用法"
            description: "TabBar 与 TabButton 的基本使用，点击标签切换 currentIndex"
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            TabButton { text: "首页" }
            TabButton { text: "消息" }
            TabButton { text: "我的" }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Qt.rgba(0.9, 0.9, 0.9, 1)
            radius: 4

            Text {
                anchors.centerIn: parent
                text: "当前选中: " + tabBar.currentIndex
                font.pointSize: 14
                color: "#333"
            }
        }
    }
}
