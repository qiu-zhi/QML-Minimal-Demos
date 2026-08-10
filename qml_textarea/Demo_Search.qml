import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 文本搜索：在搜索框输入关键词，TextArea 中匹配项以高亮选区呈现
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "文本搜索"
            description: "输入关键词后，下方 TextArea 中所有匹配项以高亮选区呈现"
        }

        TextField {
            id: searchField
            Layout.fillWidth: true
            placeholderText: "输入搜索内容..."
            // 当搜索框文本变化时，触发 TextArea 的高亮函数
            onTextChanged: searchableTextArea.highlightSearchResults()
        }

        TextArea {
            id: searchableTextArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "这是一个可以搜索的文本区域。\n尝试在上面的搜索框中输入文本，匹配的内容将会高亮显示。\nTextArea控件非常适合实现文本编辑和查看功能。"
            selectByMouse: true

            // 设置选中文本的背景颜色，用于高亮
            selectionColor: "#FFEB3B"
            selectedTextColor: "#333"

            background: Rectangle {
                color: searchableTextArea.enabled ? "white" : "#f5f5f5"
                border.color: searchableTextArea.activeFocus ? "#1296FF" : "#c0c0c0"
                border.width: searchableTextArea.activeFocus ? 2 : 1
                radius: 4
            }

            // 定义高亮搜索结果的函数
            function highlightSearchResults() {
                // 首先清除之前的所有选择/高亮
                select(0, 0)

                // 如果搜索框为空，则不进行任何操作
                if (searchField.text === "") {
                    return
                }

                var searchText = searchField.text
                var content = text
                var pos = 0

                // 循环查找所有匹配项
                while (true) {
                    pos = content.toLowerCase().indexOf(searchText.toLowerCase(), pos)
                    if (pos === -1) break // 没有找到更多匹配项

                    // 选中找到的文本，实现高亮效果
                    select(pos, pos + searchText.length)

                    // 从当前匹配项之后继续搜索
                    pos += searchText.length
                }
            }
        }
    }
}
