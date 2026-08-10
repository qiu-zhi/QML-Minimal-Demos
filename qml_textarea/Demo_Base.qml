import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 基本示例：最常用的 TextArea 用法，带边框与字符计数
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "基本示例"
            description: "最基础的 TextArea 用法，支持多行输入、自动换行，并实时统计字符数"
        }

        TextArea {
            id: basicTextArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: "请输入多行文本..."
            wrapMode: TextArea.Wrap

            // 突出文本框：增加边框
            background: Rectangle {
                color: basicTextArea.enabled ? "white" : "#f5f5f5"
                border.color: basicTextArea.activeFocus ? "#1296FF" : "#c0c0c0"
                border.width: basicTextArea.activeFocus ? 2 : 1
                radius: 4
            }

            onTextChanged: {
                console.log("字符数:", text.length)
            }
        }

        Text {
            Layout.alignment: Qt.AlignRight
            text: "字符数: " + basicTextArea.text.length
            color: "#666"
            font.pixelSize: 12
        }
    }
}
