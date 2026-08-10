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
            title: "基础示例"
            description: "TextField 的基本用法：占位文本、文本变化信号、回车确认信号"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            TextField {
                id: basicTextField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "请输入用户名..."

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }

                onTextChanged: {
                    console.log("当前输入:", text)
                }

                onAccepted: {
                    console.log("用户按下回车键")
                }
            }

            Text {
                Layout.fillWidth: true
                text: "输入内容: " + basicTextField.text
                elide: Text.ElideRight
                font.pointSize: 10
                color: "#666"
            }
        }

        Item { Layout.fillHeight: true }
    }
}
