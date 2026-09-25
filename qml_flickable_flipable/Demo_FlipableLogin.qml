import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Flipable 登录设置"
            description: "登录界面与设置界面通过翻转切换，使用 IconTextField 和 PrimaryButton 自定义组件"
        }

        Flipable {
            id: flipable
            Layout.fillWidth: true
            Layout.fillHeight: true

            property bool flipped: false

            front: Rectangle {
                anchors.fill: parent
                color: "#f8f9fa"
                radius: 6

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    Text {
                        text: "用户登录"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    IconTextField {
                        id: usernameField
                        Layout.fillWidth: true
                        placeholderText: "请输入用户名"
                        iconSource: "qrc:/images/user-icon.png"
                    }

                    IconTextField {
                        id: passwordField
                        Layout.fillWidth: true
                        placeholderText: "请输入密码"
                        echoMode: TextField.Password
                        iconSource: "qrc:/images/lock-icon.png"
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Item { Layout.fillWidth: true }
                        Button {
                            text: "登录设置"
                            flat: true
                            font.pixelSize: 12
                            onClicked: flipable.flipped = true
                        }
                    }

                    PrimaryButton {
                        text: "登 录"
                        Layout.fillWidth: true
                        enabled: usernameField.text !== "" && passwordField.text !== ""
                        onClicked: console.log("登录:", usernameField.text)
                    }
                }
            }

            back: Rectangle {
                anchors.fill: parent
                color: "#f8f9fa"
                radius: 6

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 16
                    spacing: 12

                    Text {
                        text: "登录设置"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    CheckBox {
                        text: "记住密码"
                        Layout.fillWidth: true
                    }

                    CheckBox {
                        text: "自动登录"
                        Layout.fillWidth: true
                    }

                    CheckBox {
                        text: "启用指纹登录"
                        Layout.fillWidth: true
                    }

                    Item { Layout.fillHeight: true }

                    PrimaryButton {
                        text: "保存并返回"
                        Layout.fillWidth: true
                        onClicked: flipable.flipped = false
                    }
                }
            }

            transform: Rotation {
                id: rotation
                origin.x: flipable.width / 2
                origin.y: flipable.height / 2
                axis.x: 0; axis.y: 1; axis.z: 0
                angle: 0
            }

            states: State {
                name: "back"
                when: flipable.flipped
                PropertyChanges { target: rotation; angle: 180 }
            }

            transitions: Transition {
                NumberAnimation {
                    target: rotation
                    property: "angle"
                    duration: 600
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
