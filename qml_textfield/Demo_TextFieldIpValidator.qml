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
            title: "IP地址校验"
            description: "使用 JS 工具函数校验 IPv4 / IPv6 地址格式"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 480
            spacing: 15

            TextArea {
                Layout.fillWidth: true
                Layout.preferredHeight: 110
                readOnly: true
                wrapMode: TextArea.Wrap
                text: "IPv6测试数据：\n" +
                      "2001:0db8:0000:0000:0000:ff00:0042:8329\n" +
                      "2001:db8::ff00:42:8329\n" +
                      "0000:0000:0000:0000:0000:0000:0000:0001\n" +
                      "::1\n" +
                      "::ffff:192.168.1.1\n" +
                      "fe80::aede:48ff:fe00:1122%en0"
                font.pointSize: 9
                color: "#666"
            }

            // IP 地址输入框
            TextField {
                id: ipTextField
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                placeholderText: "输入IP地址"

                // 允许数字、字母和常用符号
                inputMethodHints: Qt.ImhUrlCharactersOnly

                // 背景框
                background: Rectangle {
                    border.color: "#c0c0c0"
                    border.width: 1
                    radius: 4
                }

                // 文本改变时进行校验
                onTextChanged: {
                    RegexUtils.validateIp(text);
                }
            }

            // 用于显示校验结果的 Label
            Label {
                id: ipStatus
                Layout.fillWidth: true
                text: "请输入 IP 地址"
                font.pointSize: 10
                wrapMode: Label.WordWrap
            }
        }

        Item { Layout.fillHeight: true }
    }
}
