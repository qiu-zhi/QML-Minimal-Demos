import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 主题：暗色主题 TextArea，自定义背景、字色与选区色
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "暗色主题"
            description: "自定义深色背景、浅色文字与高亮选区，实现暗色主题文本区"
        }

        ScrollView {
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            TextArea {
                id: darkTextArea
                width: scrollView.width
                placeholderText: "暗色主题的文本区域"

                // 暗色主题样式
                color: "#e0e0e0"
                selectionColor: "#4CAF50"
                selectedTextColor: "#ffffff"
                placeholderTextColor: "#808080"

                background: Rectangle {
                    color: "#333333"
                    border.color: darkTextArea.activeFocus ? "#4CAF50" : "#555555"
                    border.width: darkTextArea.activeFocus ? 2 : 1
                    radius: 4
                }
            }
        }
    }
}
