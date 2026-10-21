import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qml_styles

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "默认控件"
            description: "同一份代码在不同样式下画出来完全不同。换一次样式再回到这页对比即可。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Button { text: "普通按钮"; font.pointSize: 11 }
            Button { text: "禁用按钮"; enabled: false; font.pointSize: 11 }
            Button { text: "高亮按钮"; highlighted: true; font.pointSize: 11 }
            RoundButton { text: "圆"; font.pointSize: 11 }

            Item { Layout.fillWidth: true }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            CheckBox { text: "复选项"; checked: true; font.pointSize: 11 }
            Switch { text: "开关"; checked: true; font.pointSize: 11 }
            RadioButton { text: "单选项"; checked: true; font.pointSize: 11 }

            Item { Layout.fillWidth: true }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            Slider {
                Layout.fillWidth: true
                value: 0.4
            }

            ProgressBar {
                Layout.preferredWidth: 160
                value: 0.65
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            TextField {
                Layout.fillWidth: true
                text: "示例文本"
                font.pointSize: 11
            }

            ComboBox {
                Layout.preferredWidth: 130
                model: ["选项一", "选项二", "选项三"]
                font.pointSize: 11
            }

            SpinBox {
                from: 0
                to: 100
                value: 30
                font.pointSize: 11
            }
        }

        Item { Layout.fillHeight: true }
    }
}
