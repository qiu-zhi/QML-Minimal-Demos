import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// MarkDown编辑器：左侧输入 Markdown，右侧实时预览渲染结果
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "MarkDown 编辑器"
            description: "左侧输入 Markdown 文本，右侧以 Text.MarkdownText 实时渲染预览"
        }

        // 解决了同步滚动的问题
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: parent.width
            contentHeight: Math.max(markdownPreview.implicitHeight,
                                    markdownInput.implicitHeight,
                                    parent.height)
            clip: true
            ScrollBar.vertical: ScrollBar {}

            SplitView {
                anchors.fill: parent

                // Markdown 输入区域
                TextArea {
                    id: markdownInput
                    SplitView.preferredWidth: parent.width / 2
                    placeholderText: "输入 Markdown 文本..."
                    font.family: "Courier New"
                    wrapMode: TextArea.Wrap

                    background: Rectangle {
                        color: markdownInput.enabled ? "white" : "#f5f5f5"
                        border.color: markdownInput.activeFocus ? "#1296FF" : "#c0c0c0"
                        border.width: markdownInput.activeFocus ? 2 : 1
                        radius: 4
                    }
                }

                // Markdown 预览区域
                Text {
                    id: markdownPreview
                    SplitView.fillWidth: true
                    wrapMode: Text.Wrap
                    textFormat: Text.MarkdownText
                    text: markdownInput.text
                    padding: 10
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }
    }
}
