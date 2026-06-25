import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ScrollView 容器"
            description: "提供滚动功能，自动处理内容溢出"
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 15

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 200
                border.color: "#ccc"
                radius: 4

                ScrollView {
                    anchors.fill: parent
                    anchors.margins: 12
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                    ColumnLayout {
                        spacing: 6

                        Repeater {
                            model: ["### ScrollView容器", "**特性:**", "- 继承自 Pane", "- 提供滚动功能", "- 自动处理内容溢出", "- 支持水平和垂直滚动", "- 可配置滚动条策略"]
                            Label {
                                required property string modelData
                                text: modelData
                                Layout.fillWidth: true
                                font.pointSize: 10
                                textFormat: Text.MarkdownText
                            }
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
