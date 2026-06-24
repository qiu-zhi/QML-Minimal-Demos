import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 750
    height: 520
    title: "Window & Popup Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        background: Rectangle { color: "#1976D2" }
        Label {
            text: "Window & Popup Demo"
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.centerIn: parent
        }
    }

    // 底部状态栏
    footer: ToolBar {
        background: Rectangle { color: "#f5f5f5"; border.color: "#ddd"; border.width: 1 }
        Label {
            text: "Qt 6 QML 示例"
            color: "#666"
            font.pointSize: 10
            anchors.centerIn: parent
        }
    }

    RowLayout {
        anchors.fill: parent

        // 左侧导航栏
        ListView {
            id: navList
            Layout.preferredWidth: 160
            Layout.fillHeight: true
            section.property: "category"
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                width: parent ? parent.width : 160
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
                ListElement { name: "Popup 弹窗"; category: "弹窗" }
                ListElement { name: "Dialog 对话框"; category: "弹窗" }
                ListElement { name: "自定义弹窗"; category: "弹窗" }

                ListElement { name: "Qt.Tool"; category: "窗口标志位" }
                ListElement { name: "Qt.ToolTip"; category: "窗口标志位" }
                ListElement { name: "Qt.SplashScreen"; category: "窗口标志位" }
                ListElement { name: "Qt.Frameless"; category: "窗口标志位" }
                ListElement { name: "Qt.StayOnTop"; category: "窗口标志位" }
                ListElement { name: "Qt.Dialog"; category: "窗口标志位" }
            }

            delegate: Rectangle {
                width: parent ? parent.width : 160
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parent.ListView.view.currentIndex = index
                        contentStack.currentIndex = index
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

        // 右侧内容区
        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true

            // 弹窗
            Demo_PopupBasic {}
            Demo_PopupDialog {}
            Demo_PopupCustom {}

            // 窗口标志位
            Demo_WindowTool {}
            Demo_WindowToolTip {}
            Demo_WindowSplash {}
            Demo_WindowFrameless {}
            Demo_WindowStayOnTop {}
            Demo_WindowDialog {}
        }
    }
}
