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
            title: "输入限制"
            description: "maximumLength 限制最大长度、echoMode 密码输入、readOnly 只读文本"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            // 限制最大长度
            TextField {
                id: maxLengthField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "最多10个字符"
                maximumLength: 10

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }
            }

            // 密码输入框
            TextField {
                id: passwordField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "请输入密码"
                echoMode: TextField.Password
                passwordCharacter: "*"

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }
            }

            // 只读文本框
            TextField {
                id: readOnlyField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                text: "只读内容"
                readOnly: true

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
