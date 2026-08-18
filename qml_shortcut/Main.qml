import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "Shortcut Demo"
    color: "#FFF"

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
                ListElement { name: "快捷键"; category: "基础用法"; source: "Demo_ShortcutBase.qml" }
                ListElement { name: "组合键序列"; category: "基础用法"; source: "Demo_ShortcutSequence.qml" }

                ListElement { name: "单键快捷键"; category: "按键类型"; source: "Demo_SingleKey.qml" }
                ListElement { name: "修饰键组合"; category: "按键类型"; source: "Demo_ModifierKeys.qml" }

                ListElement { name: "快捷键菜单"; category: "应用场景"; source: "Demo_ShortcutActions.qml" }
                ListElement { name: "状态切换"; category: "应用场景"; source: "Demo_ShortcutToggle.qml" }

                ListElement { name: "上下文作用域"; category: "进阶用法"; source: "Demo_ShortcutContext.qml" }
                ListElement { name: "多快捷键管理"; category: "进阶用法"; source: "Demo_MultiShortcut.qml" }
            }

            delegate: Rectangle {
                width: parent ? parent.width : 170
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parent.ListView.view.currentIndex = index
                        pageLoader.source = model.source
                    }
                }

                Text {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: "#333"
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
