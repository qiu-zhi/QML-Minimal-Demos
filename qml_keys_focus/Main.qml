import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 820
    height: 560
    title: "Keys & Focus Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Label {
            text: "Keys & Focus Demo"
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
            Layout.preferredWidth: 180
            Layout.fillHeight: true
            clip: true
            section.property: "category"
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                width: parent ? parent.width : 180
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
                ListElement { name: "按键事件"; category: "基础按键事件"; source: "Demo_KeysBasic.qml" }
                ListElement { name: "修饰键检测"; category: "基础按键事件"; source: "Demo_KeyModifiers.qml" }

                ListElement { name: "forceActiveFocus"; category: "焦点管理"; source: "Demo_ForceActiveFocus.qml" }
                ListElement { name: "FocusScope 焦点域"; category: "焦点管理"; source: "Demo_FocusScope.qml" }

                ListElement { name: "Tab顺序导航"; category: "焦点导航"; source: "Demo_TabNavigation.qml" }
                ListElement { name: "方向键导航"; category: "焦点导航"; source: "Demo_KeyNavigation.qml" }
                ListElement { name: "方向键控制"; category: "焦点导航"; source: "Demo_GameControlKeys.qml" }

                ListElement { name: "传播与拦截"; category: "事件传播"; source: "Demo_KeyPropagation.qml" }

            }

            delegate: Rectangle {
                width: parent ? parent.width : 180
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
