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
            title: "手机号校验"
            description: "使用正则表达式校验中国大陆手机号格式"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            TextField {
                id: validatedField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "请输入手机号"

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^1[3-9]\d{9}$/
                }

                onTextChanged: {
                    if (acceptableInput) {
                        logText.text = "手机号有效";
                    } else {
                        logText.text = "手机号格式不正确";
                    }
                }
            }

            Text {
                id: logText
                Layout.fillWidth: true
                elide: Text.ElideRight
                color: validatedField.acceptableInput ? "green" : "red"
                font.pointSize: 10
            }
        }

        Item { Layout.fillHeight: true }
    }
}
