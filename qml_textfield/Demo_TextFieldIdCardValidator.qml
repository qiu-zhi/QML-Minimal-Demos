import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import "./tools/regex_utils.js" as RegexUtils

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "身份证校验"
            description: "使用 JS 工具函数校验身份证号格式"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            // 身份证号输入框
            TextField {
                id: idTextField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "输入身份证号"

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }

                // 文本改变时进行校验
                onTextChanged: {
                    RegexUtils.validateIDCard(text);
                }
            }

            // 用于显示校验结果的 Label
            Label {
                id: idStatus
                Layout.fillWidth: true
                text: "输入身份证号"
                font.pointSize: 10
                wrapMode: Label.WordWrap
            }
        }

        Item { Layout.fillHeight: true }
    }
}
