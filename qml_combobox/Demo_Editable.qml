import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "可编辑的 ComboBox"
            description: "editable: true 启用编辑功能，配合 RegularExpressionValidator 限制输入格式，回车时自动去重添加"
        }

        ComboBox {
            id: cbox
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            editable: true

            model: ["100"]

            validator: RegularExpressionValidator {
                regularExpression: /^[A-Za-z0-9_]+$/
            }

            onAccepted: {
                if (cbox.find(editText) === -1) {
                    model = model.concat(editText)
                }
            }
        }

        Text {
            Layout.fillWidth: true
            color: "#333"
            font.pointSize: 11
            text: "当前输入: " + cbox.editText
        }

        Item { Layout.fillHeight: true }
    }
}
