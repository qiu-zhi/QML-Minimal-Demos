import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 900
    height: 600
    title: "Text & Label Demo"
    color: "#FFF"

    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle { color: "#1296FF" }
        Label {
            text: root.title
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    footer: ToolBar {
        background: Rectangle { color: "#f5f5f5"; border.color: "#ddd"; border.width: 1 }
        Label {
            text: "Qt6 QML 文本示例"
            color: "#666"
            font.pointSize: 10
            anchors.centerIn: parent
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        ListView {
            id: navList
            Layout.preferredWidth: 170
            Layout.fillHeight: true
            clip: true
            currentIndex: 0

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
                ListElement { name: "基础用法"; category: "Text组件"; source: "Demo_TextBasic.qml" }
                ListElement { name: "字体属性"; category: "Text组件"; source: "Demo_TextFont.qml" }
                ListElement { name: "文本样式"; category: "Text组件"; source: "Demo_TextStyle.qml" }
                ListElement { name: "文本对齐"; category: "Text组件"; source: "Demo_TextAlignment.qml" }
                ListElement { name: "文本换行"; category: "Text组件"; source: "Demo_TextWrap.qml" }
                ListElement { name: "文本省略"; category: "Text组件"; source: "Demo_TextElide.qml" }
                ListElement { name: "富文本HTML"; category: "Text组件"; source: "Demo_TextRich.qml" }
                ListElement { name: "Markdown"; category: "Text组件"; source: "Demo_TextMarkdown.qml" }
                ListElement { name: "链接交互"; category: "Text组件"; source: "Demo_TextLink.qml" }
                ListElement { name: "字体自适应"; category: "Text组件"; source: "Demo_TextFit.qml" }
                ListElement { name: "可点击文本"; category: "Text组件"; source: "Demo_TextClickable.qml" }
                ListElement { name: "基础用法"; category: "Label组件"; source: "Demo_LabelBasic.qml" }
                ListElement { name: "背景支持"; category: "Label组件"; source: "Demo_LabelBackground.qml" }
                ListElement { name: "内边距控制"; category: "Label组件"; source: "Demo_LabelPadding.qml" }
                ListElement { name: "Text vs Label"; category: "对比"; source: "Demo_TextVsLabel.qml" }
            }

            delegate: Rectangle {
                width: parent ? parent.width : 170
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"

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

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: "#ddd"
        }

        Loader {
            id: pageLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: navList.model.get(0).source
        }
    }
}
