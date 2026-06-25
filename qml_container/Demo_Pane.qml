import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Pane 容器"
            description: "最基础的容器组件，提供默认背景和内边距"
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 15

            Pane {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                padding: 15

                Label {
                    anchors.fill: parent
                    text: "- 默认背景色与应用主题匹配\n- 不提供布局，需自行创建\n- 支持自定义背景\n- 适合作为内容容器"
                    font.pointSize: 10
                    textFormat: Text.MarkdownText
                    wrapMode: Text.WordWrap
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
