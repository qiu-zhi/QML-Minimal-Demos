import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "Button Collection Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Label {
            text: "Button Collection Demo"
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
                ListElement { name: "普通按钮"; category: "基础按钮"; source: "Demo_Button.qml" }
                ListElement { name: "圆形按钮"; category: "基础按钮"; source: "Demo_RoundButton.qml" }
                ListElement { name: "延迟按钮"; category: "基础按钮"; source: "Demo_DelayButton.qml" }

                ListElement { name: "开关按钮"; category: "选择控件"; source: "Demo_Switch.qml" }
                ListElement { name: "复选框"; category: "选择控件"; source: "Demo_CheckBox.qml" }
                ListElement { name: "单选按钮"; category: "选择控件"; source: "Demo_RadioButton.qml" }

                ListElement { name: "菜单按钮"; category: "菜单与标签"; source: "Demo_ToolButton.qml" }
                ListElement { name: "标签按钮"; category: "菜单与标签"; source: "Demo_TabButton.qml" }

                ListElement { name: "列表项"; category: "列表与自定义"; source: "Demo_ItemDelegate.qml" }
                ListElement { name: "自定义按钮"; category: "列表与自定义"; source: "Demo_CustomButton.qml" }
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
