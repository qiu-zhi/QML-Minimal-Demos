import QtQuick
import QtQuick.Controls

// 自定义带行号的文本编辑器组件
Item {

    // 公开的属性
    property alias text: textArea.text
    property alias placeholderText: textArea.placeholderText
    property alias font: textArea.font
    property alias textArea: textArea
    property int lineNumberWidth: 50
    property color lineNumberBackground: "#f0f0f0"
    property color lineNumberColor: "#808080"
    property color textAreaBackground: "white"

    // 行号和文本区域的布局
    Row {
        anchors.fill: parent
        spacing: 0

        // 行号区域
        Rectangle {
            width: lineNumberWidth
            height: parent.height
            color: lineNumberBackground
            clip: true

            Flickable {
                id: lineNumberFlickable
                anchors.fill: parent
                contentY: flickable.contentY
                contentHeight: textArea.contentHeight
                interactive: false

                TextArea {
                    id: lineNumbers
                    width: parent.width
                    height: textArea.contentHeight + 30
                    readOnly: true
                    selectByMouse: false
                    font: textArea.font
                    color: lineNumberColor
                    horizontalAlignment: Text.AlignRight
                    rightPadding: 4
                    leftPadding: 4
                    background: null

                    Component.onCompleted: {
                        updateLineNumbers()
                    }

                    function updateLineNumbers() {
                        var count = textArea.lineCount
                        var newText = ""
                        for (var i = 0; i < count; i++) {
                            newText += (i + 1) + "\n"
                        }
                        text = newText.trim()
                    }
                }
            }
        }

        // 文本编辑区域
        Rectangle {
            width: parent.width - lineNumberWidth
            height: parent.height
            color: textAreaBackground

            Flickable {
                id: flickable
                anchors.fill: parent
                clip: true
                contentWidth: textArea.width
                contentHeight: textArea.contentHeight
                boundsBehavior: Flickable.StopAtBounds

                // 添加滚动条
                ScrollBar.vertical: ScrollBar {
                    id: vbar
                    policy: ScrollBar.AsNeeded
                    active: true
                }

                TextArea {
                    id: textArea
                    width: flickable.width
                    height: Math.max(flickable.height, contentHeight + 30)
                    placeholderText: "输入文本..."
                    font.pixelSize: 14
                    wrapMode: TextArea.NoWrap
                    leftPadding: 4
                    rightPadding: 4
                    topPadding: 4
                    bottomPadding: 4
                    selectByMouse: true
                    persistentSelection: true
                    background: null

                    onLineCountChanged: {
                        lineNumbers.updateLineNumbers()
                    }

                    // 确保文本改变时更新行号
                    onTextChanged: {
                        lineNumbers.updateLineNumbers()
                    }

                    // 添加尺寸变化处理
                    onContentHeightChanged: {
                        lineNumbers.updateLineNumbers()
                    }
                }
            }
        }
    }

    // 初始化
    Component.onCompleted: {
        textArea.forceActiveFocus()
    }
}
