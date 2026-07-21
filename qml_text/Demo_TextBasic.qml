import QtQuick
import QtQuick.Layouts

DemoPage {
    title: "Text 基础用法"
    description: "演示 Text 组件的基本属性：纯文本显示、颜色、粗体、斜体、下划线、删除线"

    ColumnLayout {
        Layout.leftMargin: 20
        spacing: 12

        Text {
            text: "普通文本 - Hello World!"
            font.pointSize: 12
        }

        Text {
            text: "带颜色文本"
            font.pointSize: 12
            color: "#E91E63"
        }

        Text {
            text: "粗体文本"
            font.pointSize: 12
            font.bold: true
        }

        Text {
            text: "斜体文本"
            font.pointSize: 12
            font.italic: true
        }

        Text {
            text: "下划线文本"
            font.pointSize: 12
            font.underline: true
        }

        Text {
            text: "删除线文本"
            font.pointSize: 12
            font.strikeout: true
        }
    }
}
