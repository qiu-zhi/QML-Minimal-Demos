import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "TextArea Demo"
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
        anchors.fill: parent
        spacing: 0

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
                ListElement { name: "基本示例"; category: "TextArea基础"; source: "Demo_Base.qml" }
                ListElement { name: "字体与颜色"; category: "TextArea基础"; source: "Demo_FontColor.qml" }
                ListElement { name: "富文本"; category: "TextArea基础"; source: "Demo_Rich.qml" }
                ListElement { name: "换行模式"; category: "TextArea基础"; source: "Demo_Wrap.qml" }

                ListElement { name: "自定义样式"; category: "TextArea样式"; source: "Demo_Style.qml" }
                ListElement { name: "暗色主题"; category: "TextArea样式"; source: "Demo_Theme.qml" }
                ListElement { name: "Material 风格"; category: "TextArea样式"; source: "Demo_Material.qml" }

                ListElement { name: "文本搜索"; category: "TextArea应用"; source: "Demo_Search.qml" }
                ListElement { name: "带行号的文本编辑器"; category: "TextArea应用"; source: "Demo_LineNum.qml" }
                ListElement { name: "MarkDown编辑器"; category: "TextArea应用"; source: "Demo_Markdown.qml" }
                ListElement { name: "保持滚动"; category: "TextArea应用"; source: "Demo_Scroll.qml" }
                ListElement { name: "加载大文本"; category: "TextArea应用"; source: "Demo_VirtualText.qml" }
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
