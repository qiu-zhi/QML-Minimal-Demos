import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 900
    height: 600
    title: "Layout Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Label {
            text: "Layout Demo"
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

    // 页面源列表，用于 Loader 按需加载
    property var pageSources: [
        "Demo_Row.qml",
        "Demo_Column.qml",
        "Demo_Grid.qml",
        "Demo_Stack.qml",
        "Demo_Flow.qml",
    ]

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // 左侧导航栏
        ListView {
            id: navList
            Layout.preferredWidth: 160
            Layout.fillHeight: true
            clip: true

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
                ListElement { name: "水平布局"; category: "基础布局" }
                ListElement { name: "垂直布局"; category: "基础布局" }
                ListElement { name: "网格布局"; category: "基础布局" }
                ListElement { name: "堆叠布局"; category: "基础布局" }
                ListElement { name: "流式布局"; category: "基础布局" }
            }

            delegate: Rectangle {
                width: parent ? parent.width : 160
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        navList.currentIndex = index
                        pageLoader.source = root.pageSources[index]
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

        // 分隔线
        Rectangle {
            Layout.fillHeight: true
            width: 1
            color: "#ddd"
        }

        // 右侧内容区：使用 Loader 延迟加载，只实例化当前页面
        Loader {
            id: pageLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: root.pageSources[0]
        }
    }
}
