import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "Navigation Layout Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Text {
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
            currentIndex: 0
            section.property: "category"
            section.criteria: ViewSection.FullString

            section.delegate: Rectangle {
                required property string section

                width: navList.width
                height: 35
                color: "#F5F7FA"

                Text {
                    x: 6
                    anchors.verticalCenter: parent.verticalCenter
                    text: parent.section
                    color: "#1296FF"
                    font.pointSize: 12
                    font.bold: true
                }
            }

            model: ListModel {
                ListElement { name: "顶部导航栏"; category: "导航布局"; source: "Demo_TopNavigation.qml" }
                ListElement { name: "抽屉式导航"; category: "导航布局"; source: "Demo_DrawerNavigation.qml" }
                ListElement { name: "侧边导航栏"; category: "导航布局"; source: "Demo_SidebarNavigation.qml" }
                ListElement { name: "底部导航栏"; category: "导航布局"; source: "Demo_BottomNavigation.qml" }
            }

            delegate: Rectangle {
                id: navDelegate
                required property string name
                required property string source
                required property int index

                width: navList.width
                height: 40
                color: navDelegate.ListView.isCurrentItem ? "#BCE6FF" : "#FFF"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        navList.currentIndex = navDelegate.index
                        pageLoader.source = navDelegate.source
                    }
                }

                Text {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: navDelegate.name
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
            // 页面内容一律限制在内容区内，避免动画过程中压住左侧导航
            clip: true
            source: "Demo_TopNavigation.qml"
        }
    }
}
