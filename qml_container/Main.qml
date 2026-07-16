import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 750
    height: 520
    title: "Container Demo"
    color: "#FFF"

    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle { color: "#1296FF" }
        Label {
            text: "Container Demo"
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

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
        anchors.fill: parent

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
                ListElement { name: "Pane"; category: "基础容器" }
                ListElement { name: "Frame"; category: "基础容器" }
                ListElement { name: "GroupBox"; category: "基础容器" }
                ListElement { name: "自定义GroupBox"; category: "进阶用法" }
                ListElement { name: "ScrollView"; category: "进阶用法" }
                ListElement { name: "嵌套组合"; category: "进阶用法" }
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

        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true

            Demo_Pane {}
            Demo_Frame {}
            Demo_GroupBox {}
            Demo_CustomGroupBox {}
            Demo_ScrollView {}
            Demo_Nested {}
        }
    }
}
