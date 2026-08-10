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
            title: "年龄校验"
            description: "使用 IntValidator 限制输入 0-150 之间的整数，并实时显示校验结果"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            TextField {
                id: validatedField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "请输入年龄(0-150)"

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }

                validator: IntValidator {
                    bottom: 0
                    top: 150
                }

                onTextChanged: {
                    if (acceptableInput) {
                        logText.text = "有效年龄:" + text;
                    } else {
                        logText.text = "无效输入...";
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
