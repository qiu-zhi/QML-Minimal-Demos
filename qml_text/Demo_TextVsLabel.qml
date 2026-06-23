import QtQuick
import QtQuick.Controls

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text vs Label 对比"
        }

        Text {
            text: "对比 Text 和 Label 组件：字体继承、背景支持、适用场景"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
            width: parent.width - 40
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Row {
                spacing: 20

                // Text组件
                Column {
                    spacing: 5

                    Text {
                        text: "Text组件"
                        font.pointSize: 11
                        font.bold: true
                        color: "#1976D2"
                    }

                    Text {
                        text: "手动设置字体"
                        font.pointSize: 10
                    }

                    Text {
                        text: "不支持背景"
                        font.pointSize: 10
                    }

                    Text {
                        text: "适合: 文本展示"
                        font.pointSize: 10
                        color: "#666"
                    }
                }

                Rectangle {
                    width: 1
                    height: 80
                    color: "#ddd"
                }

                // Label组件
                Column {
                    spacing: 5

                    Text {
                        text: "Label组件"
                        font.pointSize: 11
                        font.bold: true
                        color: "#E91E63"
                    }

                    Label {
                        text: "继承应用字体"
                        font.pointSize: 10
                    }

                    Label {
                        text: "支持背景"
                        font.pointSize: 10
                    }

                    Label {
                        text: "适合: 表单设置"
                        font.pointSize: 10
                        color: "#666"
                    }
                }
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "- 简单文本展示: Text"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- 需要背景/表单: Label"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "- 与控件配合: Label"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
