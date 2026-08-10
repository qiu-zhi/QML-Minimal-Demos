import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 富文本：对比纯文本与富文本两种 textFormat 的渲染效果
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "富文本"
            description: "上方为纯文本输入区，下方以 RichText 格式实时渲染 HTML 标签"
        }

        TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.minimumHeight: 120
            textFormat: TextArea.PlainText
            wrapMode: TextArea.Wrap
            text: "<h1>富文本示例</h1><p>这是<b>加粗</b>文本，这是<i>斜体</i>文本。</p><ul><li>列表项1</li><li>列表项2</li></ul>"

            background: Rectangle {
                color: textArea.enabled ? "white" : "#f5f5f5"
                border.color: textArea.activeFocus ? "#1296FF" : "#c0c0c0"
                border.width: textArea.activeFocus ? 2 : 1
                radius: 4
            }
        }

        TextArea {
            id: richView
            Layout.fillWidth: true
            Layout.fillHeight: true
            textFormat: TextArea.RichText
            wrapMode: TextArea.Wrap
            text: textArea.text
            readOnly: true

            background: Rectangle {
                color: "#fafafa"
                border.color: "#c0c0c0"
                border.width: 1
                radius: 4
            }

            onTextChanged: {
                if (textFormat === TextEdit.RichText) {
                    console.log("当前内容为富文本格式")
                }
            }
        }
    }
}
