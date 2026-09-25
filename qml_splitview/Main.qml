pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "SplitView Demo"
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
                id: sectionRect
                required property string section
                width: parent ? parent.width : 170
                height: 35
                color: "#F5F7FA"
                Text {
                    x: 6
                    anchors.verticalCenter: parent.verticalCenter
                    text: sectionRect.section
                    color: "#1296FF"
                    font.pointSize: 12
                    font.bold: true
                }
            }
            model: ListModel {
                ListElement { name: "SplitView"; category: "基础用法"; source: "Demo_BasicSplitView.qml" }
                ListElement { name: "Handle 样式"; category: "基础用法"; source: "Demo_CustomHandle.qml" }
                ListElement { name: "嵌套布局"; category: "基础用法"; source: "Demo_NestedSplitView.qml" }
                ListElement { name: "状态持久化"; category: "基础用法"; source: "Demo_StatePersistence.qml" }
            }

            delegate: Rectangle {
                id: delegateRoot
                required property string name
                required property string source
                required property int index
                width: parent ? parent.width : 170
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        autoSwitchTimer.stop()
                        navList.currentIndex = delegateRoot.index
                        pageLoader.source = delegateRoot.source
                    }
                    onDoubleClicked: {
                        autoSwitchTimer.start()
                    }
                }

                Text {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: delegateRoot.name
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
