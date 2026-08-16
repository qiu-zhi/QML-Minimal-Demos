import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "部分选项禁用"
            description: "在 delegate 中通过 enabled 属性控制选项可用性，禁用项以半透明样式呈现"
        }

        ComboBox {
            id: disableItemsCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            model: ["可用选项", "禁用选项", "另一个可用选项"]

            delegate: ItemDelegate {
                width: disableItemsCombo.width
                text: modelData
                enabled: modelData !== "禁用选项"
                opacity: enabled ? 1 : 0.5
            }
        }

        Text {
            id: textResult
            Layout.fillWidth: true
            color: "#333"
            font.pointSize: 11
            text: disableItemsCombo.currentIndex >= 0
                  ? "当前选择: " + disableItemsCombo.currentText
                  : "未选择"
        }

        Item { Layout.fillHeight: true }
    }
}
