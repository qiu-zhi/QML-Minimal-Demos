import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 样式：使用 Flickable 包装 TextArea，实现可滚动且自定义背景边框的样式
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "自定义样式"
            description: "用 Flickable 包装 TextArea，内容超出时可滚动，并自定义背景与边框"
        }

        Flickable {
            id: flickable
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: textArea.width
            contentHeight: textArea.height
            clip: true

            TextArea {
                id: textArea
                width: flickable.width
                height: Math.max(flickable.height, implicitHeight)
                placeholderText: "自定义样式的文本区域"
                wrapMode: TextArea.Wrap
                text: "这是一个测试文本，用于演示滚动功能。\n".repeat(30)
                selectByMouse: true
                mouseSelectionMode: TextEdit.SelectCharacters

                background: Rectangle {
                    implicitWidth: flickable.width
                    implicitHeight: flickable.height
                    color: textArea.enabled ? "white" : "#f5f5f5"
                    border.color: textArea.activeFocus ? "#1296FF" : "#c0c0c0"
                    border.width: textArea.activeFocus ? 2 : 1
                    radius: 4
                }
            }
        }
    }
}
