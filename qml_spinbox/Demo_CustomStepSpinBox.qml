import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义步长 SpinBox"
            description: "通过 ComboBox 切换 stepSize，配合 textFromValue/valueFromText 实现 ° 单位显示"
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            spacing: 10

            SpinBox {
                id: spinBox
                implicitHeight: 30

                from: -100
                to: 100
                stepSize: 10
                value: 0
                editable: true

                // 自定义显示格式：在数值后追加 °
                textFromValue: function(value, locale) {
                    return value + "°"
                }

                // 自定义输入解析：去除 ° 后转为数字
                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text.replace("°", ""))
                }
            }

            // 步长控制
            ComboBox {
                id: stepControl
                implicitHeight: 30
                model: ["1", "5", "10", "15", "20"]
                onCurrentTextChanged: {
                    spinBox.stepSize = Number(currentText)
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "当前值：" + spinBox.value + "°，步长：" + spinBox.stepSize
            font.pointSize: 11
            color: "#333"
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：通过 ComboBox 可切换步长，支持 -100 到 100 的角度范围"
        }

        Item { Layout.fillHeight: true }
    }
}
