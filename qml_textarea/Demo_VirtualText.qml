import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 由 C++ TextLoader 读取《白话史记》并按行分块（换行即分段）。
    // textLoader 是 main.cpp 中 setContextProperty 注册的 context property；
    // 若未重新构建或单独预览本文件，textLoader 为 null 会导致
    // "Cannot call method 'load' of null"，这里延迟到 onCompleted 加载并给出明确提示
    property var textData: ({ blocks: [], totalChars: 0 })

    Component.onCompleted: {
        if (textLoader)
            textData = textLoader.load("qrc:/qt/qml/qml_textarea/白话史记.txt")
        else
            textData = { error: "textLoader 未注册：请确认 main.cpp 已调用 setContextProperty(\"textLoader\", ...) 并重新构建后运行" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "加载大文本"
            description: "从《白话史记》txt 读取约 99 万字符，按行切成阅读块（换行即分段），由 ListView 虚拟化渲染，只创建可见的块"
        }

        // 统计栏
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Text {
                id: statusText
                text: textData.error ? textData.error
                                     : "共 " + textData.blocks.length + " 块，约 " + Math.round(textData.totalChars / 10000) + " 万字"
                font.pointSize: 10
                font.bold: true
                color: textData.error ? "red" : "#1296ff"
            }
            Item { Layout.fillWidth: true }
            Text {
                text: "当前第 " + (listView.currentIndex + 1) + " 块 / 共 " + listView.count + " 块"
                font.pointSize: 10
                font.bold: true
                color: "#1296ff"
            }
        }

        // 大文本虚拟化列表：只渲染可见的块，滚动流畅
        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 1
            cacheBuffer: 600
            model: textData.blocks

            delegate: Item {
                width: listView.width
                height: paraText.implicitHeight + 24

                // 相邻块用浅色底区分，方便定位
                Rectangle {
                    anchors.fill: parent
                    color: index % 2 === 0 ? "#FAFAFA" : "#FFFFFF"
                }

                Text {
                    id: paraText
                    anchors {
                        left: parent.left; right: parent.right; top: parent.top
                        leftMargin: 14; rightMargin: 14; topMargin: 12
                    }
                    text: modelData
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText
                    font.pointSize: 12
                    lineHeight: 1.6
                    color: "#333"
                }
            }
        }
    }
}
