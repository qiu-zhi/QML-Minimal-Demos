import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 750
    height: 520
    title: "Text & Label Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Label {
            text: "Text & Label Demo"
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

        // 左侧导航栏
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
                ListElement { name: "基础用法"; category: "Text组件" }
                ListElement { name: "字体属性"; category: "Text组件" }
                ListElement { name: "文本样式"; category: "Text组件" }
                ListElement { name: "文本对齐"; category: "Text组件" }
                ListElement { name: "文本换行"; category: "Text组件" }
                ListElement { name: "文本省略"; category: "Text组件" }
                ListElement { name: "富文本HTML"; category: "Text组件" }
                ListElement { name: "Markdown"; category: "Text组件" }
                ListElement { name: "链接交互"; category: "Text组件" }
                ListElement { name: "字体自适应"; category: "Text组件" }
                ListElement { name: "可点击文本"; category: "Text组件" }
                ListElement { name: "文本动画"; category: "Text组件" }

                ListElement { name: "基础用法"; category: "Label组件" }
                ListElement { name: "背景支持"; category: "Label组件" }
                ListElement { name: "内边距控制"; category: "Label组件" }

                ListElement { name: "Text vs Label"; category: "对比" }
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

        // 右侧内容区
        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Text组件
            Demo_TextBasic {}
            Demo_TextFont {}
            Demo_TextStyle {}
            Demo_TextAlignment {}
            Demo_TextWrap {}
            Demo_TextElide {}
            Demo_TextRich {}
            Demo_TextMarkdown {}
            Demo_TextLink {}
            Demo_TextFit {}
            Demo_TextClickable {}
            Demo_TextAnimation {}

            // Label组件
            Demo_LabelBasic {}
            Demo_LabelBackground {}
            Demo_LabelPadding {}

            // 对比
            Demo_TextVsLabel {}
        }
    }
}
