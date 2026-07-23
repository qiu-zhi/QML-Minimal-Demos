import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import "Utility.js" as Util

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        TitleSeparator {
            title: "导入外部 JS 文件"
            description: "通过 import \"Utility.js\" as Util 导入外部 JS 文件并调用其中函数，.pragma library 确保所有 QML 实例共享同一 JS 上下文"
        }

        // 调用外部模块的函数
        Text {
            text: "调用JS接口(formatDate): \n" + Util.formatDate(new Date())
            font.pointSize: 12
        }

        Button {
            text: "调用JS接口(toUpperCase)"
            font.pointSize: 12
            onClicked: {
                textResult.text = Util.toUpperCase(textResult.text)
            }
        }

        Text {
            id: textResult
            text: "   abcdefg   "
            font.pointSize: 10
        }

        Item { Layout.fillHeight: true }
    }
}
