import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Label 基础用法"
            description: "演示 Label 组件基础：自动继承应用字体、自定义字体大小、颜色、粗体斜体"
        }

        Label {
            text: "Label - 自动继承应用字体"
        }

        Label {
            text: "自定义字体大小"
            font.pixelSize: 24
        }

        Label {
            text: "自定义颜色"
            color: "#E91E63"
        }

        Label {
            text: "粗体 + 斜体"
            font.bold: true
            font.italic: true
        }

        Item { Layout.fillHeight: true }

        Note {
            text: "- 自动继承应用字体\n- 与应用程序样式一致\n- 适合表单、设置界面"
        }
    }
}
