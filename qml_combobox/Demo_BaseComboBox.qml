import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基本用法"
            description: "使用字符串数组作为 model，通过 onActivated 回调响应选择项变化"
        }

        ComboBox {
            id: basicComboBox
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            model: ["选项1", "选项2", "选项3"]
            onActivated: {
                textResult.text = "当前选择: " + currentText
            }
        }

        Text {
            id: textResult
            Layout.fillWidth: true
            color: "#333"
            font.pointSize: 11
        }

        Item { Layout.fillHeight: true }
    }
}
