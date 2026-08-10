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
            title: "表单提交"
            description: "用户登录表单：带图标的用户名 / 密码输入框，按钮可用性随输入联动"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 300
            spacing: 15

            Text {
                text: "用户登录"
                font.bold: true
                font.pixelSize: 18
                Layout.alignment: Qt.AlignHCenter
                color: "#2196F3"
            }

            TextField {
                id: usernameField
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                placeholderText: "用户名"
                leftPadding: 40
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14

                background: Rectangle {
                    implicitWidth: 300
                    implicitHeight: 40
                    color: "white"
                    border.color: usernameField.activeFocus ? "#2196F3" : "#BBDEFB"
                    border.width: usernameField.activeFocus ? 2 : 1
                    radius: 4

                    Image {
                        source: "/icons/user-icon.png"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20
                        height: 20
                    }
                }
            }

            TextField {
                id: passwordField
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                placeholderText: "密码"
                echoMode: TextField.Password
                leftPadding: 40
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14

                background: Rectangle {
                    implicitWidth: 300
                    implicitHeight: 40
                    color: "white"
                    border.color: passwordField.activeFocus ? "#2196F3" : "#BBDEFB"
                    border.width: passwordField.activeFocus ? 2 : 1
                    radius: 4

                    Image {
                        source: "/icons/lock-icon.png"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        width: 20
                        height: 20
                    }
                }
            }

            Button {
                text: "登录"
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                enabled: usernameField.text !== "" && passwordField.text !== ""
                hoverEnabled: false

                background: Rectangle {
                    color: parent.enabled ? (parent.pressed ? "#1976D2" : "#2196F3") : "#E3F2FD"
                    border.color: "#BBDEFB"
                    border.width: 1
                    radius: 4
                }

                contentItem: Text {
                    text: parent.text
                    color: parent.enabled ? "white" : "#90CAF9"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                }

                onClicked: {
                    console.log("尝试登录:", usernameField.text)
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
