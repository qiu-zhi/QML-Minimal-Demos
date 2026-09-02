import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 900
    height: 600
    title: "Date & Time Demo"
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
                ListElement { name: "日期格式化"; category: "日期格式"; source: "Demo_DateFormat.qml" }
                ListElement { name: "自定义格式"; category: "日期格式"; source: "Demo_CustomDateFormat.qml" }
                ListElement { name: "地区日期"; category: "日期格式"; source: "Demo_LocaleDate.qml" }

                ListElement { name: "日期解析"; category: "日期解析"; source: "Demo_DateParse.qml" }
                ListElement { name: "时间戳转换"; category: "日期解析"; source: "Demo_TimestampConvert.qml" }

                ListElement { name: "时间选择器"; category: "时间组件"; source: "Demo_TimePicker.qml" }
                ListElement { name: "日期时间选择器"; category: "时间组件"; source: "Demo_DateTimePicker.qml" }

                ListElement { name: "时钟可视化"; category: "可视化"; source: "Demo_DateTimeVisual.qml" }
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
