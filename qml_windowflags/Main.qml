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

    RowLayout {
        anchors.fill: parent

        // 左侧导航栏
        ListView {
            id: navList
            Layout.preferredWidth: 160
            Layout.fillHeight: true
            model: ListModel {
                ListElement { name: "Popup 弹窗" }
                ListElement { name: "Dialog 对话框" }
                ListElement { name: "自定义弹窗" }
                ListElement { name: "窗口标志位" }
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

            Demo_PopupBasic {}
            Demo_PopupDialog {}
            Demo_PopupCustom {}
            Demo_WindowFlags {}
        }
    }
}
