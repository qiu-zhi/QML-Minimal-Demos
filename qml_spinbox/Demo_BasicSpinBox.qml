import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础 SpinBox"
            description: "可编辑 SpinBox，配合 IntValidator 输入验证，并通过 textFromValue 自定义显示格式"
        }

        SpinBox {
            id: spinBox
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20

            implicitWidth: 140
            implicitHeight: 30

            from: 0
            to: 100
            editable: true

            // 输入验证
            validator: IntValidator {
                bottom: spinBox.from
                top: spinBox.to
            }

            // 数值显示格式化
            textFromValue: function(value, locale) {
                return Number(value).toLocaleString(locale, 'f', 0)
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "当前值：" + spinBox.value
            font.pointSize: 11
            color: "#333"
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：可编辑模式可直接输入数字，超出范围会被验证器拒绝"
        }

        Item { Layout.fillHeight: true }
    }
}
