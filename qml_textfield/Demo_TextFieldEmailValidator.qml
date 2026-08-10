import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "邮箱格式校验"
            description: "使用 RegularExpressionValidator 校验电子邮箱格式"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            TextField {
                id: regexField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "请输入电子邮箱"

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
                }

                onTextChanged: {
                    if (acceptableInput) {
                        logText.text = "有效邮箱"
                    } else {
                        logText.text = "无效邮箱"
                    }
                }
            }

            Text {
                id: logText
                Layout.fillWidth: true
                elide: Text.ElideRight
                color: regexField.acceptableInput ? "green" : "red"
                font.pointSize: 10
            }
        }

        Item { Layout.fillHeight: true }
    }
}
