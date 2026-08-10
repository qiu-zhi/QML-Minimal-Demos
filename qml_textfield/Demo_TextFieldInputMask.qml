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
            title: "掩码与日期校验"
            description: "使用 inputMask 限定日期输入格式，并通过 Date 校验有效性"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            Text {
                text: "请输入日期(YYYY-MM-DD):"
                font.pointSize: 10
                color: "#333"
            }

            TextField {
                id: maskedField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "请输入日期(YYYY-MM-DD)"
                inputMask: "9999-99-99"

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }

                // 判断正确日期
                function isValidDate(str) {
                    const fmt = Qt.formatDateTime(new Date(str), "yyyy-MM-dd");
                    return fmt === str;
                }

                onTextChanged: {
                    if (isValidDate(text)) {
                        logText.text = "正确日期：" + text;
                        logText.color = "green";
                    } else {
                        logText.text = "错误日期：" + text;
                        logText.color = "red";
                    }
                }
            }

            Text {
                id: logText
                Layout.fillWidth: true
                elide: Text.ElideRight
                font.pointSize: 10
            }
        }

        Item { Layout.fillHeight: true }
    }
}
