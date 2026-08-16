import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "ComboBox Demo"
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
                ListElement { name: "基本用法"; category: "基础用法"; source: "Demo_BaseComboBox.qml" }
                ListElement { name: "ListModel模型"; category: "基础用法"; source: "Demo_ListModel.qml" }
                ListElement { name: "自定义显示文本"; category: "基础用法"; source: "Demo_DisplayText.qml" }
                ListElement { name: "禁用选项"; category: "基础用法"; source: "Demo_DisableItem.qml" }

                ListElement { name: "可编辑ComboBox"; category: "进阶用法"; source: "Demo_Editable.qml" }
                ListElement { name: "动态更新模型"; category: "进阶用法"; source: "Demo_Dynamic.qml" }
                ListElement { name: "分组ComboBox"; category: "进阶用法"; source: "Demo_Group.qml" }
                ListElement { name: "多列ComboBox"; category: "进阶用法"; source: "Demo_MultiColumn.qml" }
                ListElement { name: "大数据性能优化"; category: "进阶用法"; source: "Demo_LargeData.qml" }

                ListElement { name: "自定义样式"; category: "样式自定义"; source: "Demo_CustomStyle.qml" }
                ListElement { name: "Material样式"; category: "样式自定义"; source: "Demo_MaterialStyle.qml" }
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
