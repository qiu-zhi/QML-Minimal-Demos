import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 保持滚动：点击按钮追加文本，垂直滚动条始终保持滚动到底端
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "保持滚动"
            description: "点击按钮追加文本，垂直滚动条 position 始终保持在底端"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "追加文本"
                onClicked: {
                    textArea.append("【追加文本】这是一个测试文本，用于演示滚动功能。\n".repeat(5))
                }
            }

            Label {
                text: "已追加文本，字符数: " + textArea.text.length
                color: "#666"
                font.pixelSize: 12
            }
        }

        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true

            ScrollBar.vertical: ScrollBar {
                anchors.top: scrollView.top
                anchors.bottom: scrollView.bottom
                anchors.right: scrollView.right
                policy: ScrollBar.AlwaysOn

                // 保持滚动到底端
                position: {
                    if (scrollView.height > 0 && scrollView.contentHeight > scrollView.height) {
                        return (scrollView.contentHeight - scrollView.height) / scrollView.contentHeight;
                    }
                    return 0;
                }
            }

            TextArea {
                id: textArea
                wrapMode: TextArea.Wrap
                text: "这是一个测试文本，用于演示滚动功能。\n".repeat(30)
                selectByMouse: true
                mouseSelectionMode: TextEdit.SelectCharacters

                background: Rectangle {
                    color: textArea.enabled ? "white" : "#f5f5f5"
                    border.color: textArea.activeFocus ? "#1296FF" : "#c0c0c0"
                    border.width: textArea.activeFocus ? 2 : 1
                    radius: 4
                }
            }
        }
    }
}
