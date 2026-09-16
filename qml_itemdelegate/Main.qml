import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "委托组件演示（ItemDelegate）"
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

        // 左侧导航栏：name 为通俗中文用途；代码类型名由右侧页面标题体现
        ListView {
            id: navList
            Layout.preferredWidth: 180
            Layout.fillHeight: true
            clip: true
            currentIndex: 0
            section.property: "category"
            section.criteria: ViewSection.FullString

            section.delegate: Rectangle {
                required property string section

                width: navList.width
                height: 30
                color: "#F5F7FA"

                Text {
                    x: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: parent.section
                    color: "#1296FF"
                    font.pointSize: 11
                    font.bold: true
                }
            }

            model: ListModel {
                ListElement { name: "点击列表项";     category: "基础委托"; source: "Demo_ItemDelegate.qml" }
                ListElement { name: "复选列表项";     category: "基础委托"; source: "Demo_CheckDelegate.qml" }
                ListElement { name: "单选列表项";     category: "基础委托"; source: "Demo_RadioDelegate.qml" }
                ListElement { name: "开关列表项";     category: "基础委托"; source: "Demo_SwitchDelegate.qml" }

                ListElement { name: "左右滑动操作";   category: "滑动委托"; source: "Demo_SwipeDelegate_Left.qml" }
                ListElement { name: "滑动露出背景";   category: "滑动委托"; source: "Demo_SwipeDelegate_Behind.qml" }

                ListElement { name: "树形列表";       category: "树视图";   source: "Demo_TreeViewDelegate.qml" }
            }

            delegate: Rectangle {
                id: navDelegate
                required property string name
                required property int index

                width: navList.width
                height: 38
                color: navDelegate.ListView.isCurrentItem ? "#BCE6FF" : "#FFF"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        navList.currentIndex = navDelegate.index
                        pageLoader.source = navDelegate.ListView.view.model.get(navDelegate.index).source
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
