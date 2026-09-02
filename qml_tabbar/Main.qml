import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "TabBar Demo"
    color: "#FFF"

    Timer {
        id: autoSwitchTimer
        interval: 1000
        repeat: true
        onTriggered: {
            var next = (navList.currentIndex + 1) % navList.model.count
            navList.currentIndex = next
            pageLoader.source = navList.model.get(next).source
        }
    }

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Label {
            text: root.title
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // 底部状态栏
    footer: ToolBar {
        background: Rectangle { color: "#f5f5f5"; border.color: "#ddd"; border.width: 1 }
        Label {
            text: "Qt6 QML示例"
            color: "#666"
            font.pointSize: 10
            anchors.centerIn: parent
        }
    }

    RowLayout {
        spacing: 0
        anchors.fill: parent

        // 左侧导航栏
        ListView {
            id: navList
            Layout.preferredWidth: 170
            Layout.fillHeight: true
            clip: true
            section.property: "category"
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                width: parent ? parent.width : 170
                height: 35
                color: "#F5F7FA"
                Text {
                    x: 6
                    anchors.verticalCenter: parent.verticalCenter
                    text: section
                    color: "#1296FF"
                    font.pointSize: 12
                    font.bold: true
                }
            }
            model: ListModel {
                ListElement { name: "基础用法"; category: "基础用法"; source: "Demo_BasicTabBar.qml" }
                ListElement { name: "TabBar 位置"; category: "基础用法"; source: "Demo_TabBarPosition.qml" }

                ListElement { name: "自定义按钮"; category: "基础用法"; source: "Demo_CustomTabButton.qml" }
                ListElement { name: "动态标签"; category: "基础用法"; source: "Demo_DynamicTabs.qml" }

                ListElement { name: "与 StackLayout"; category: "基础用法"; source: "Demo_TabBarWithStackLayout.qml" }
                ListElement { name: "与 SwipeView"; category: "基础用法"; source: "Demo_TabBarWithSwipeView.qml" }
            }

            delegate: Rectangle {
                width: parent ? parent.width : 170
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        autoSwitchTimer.stop()
                        parent.ListView.view.currentIndex = index
                        pageLoader.source = model.source
                    }
                    onDoubleClicked: {
                        autoSwitchTimer.start()
                    }
                }

                Text {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: ListView.isCurrentItem ? "#1296FF" : "#333"
                    font.pointSize: 11
                    font.bold: true
                }
            }
        }

        // 导航与内容之间的分隔线
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: "#ddd"
        }

        // 右侧内容区：使用 Loader 延迟加载，只实例化当前页面
        Loader {
            id: pageLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: navList.model.get(0).source
        }
    }
}
