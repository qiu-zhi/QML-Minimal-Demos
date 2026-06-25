import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Frame 容器"
            description: "继承自 Pane，自带边框样式，适合分组显示内容"
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 15

            Frame {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                padding: 15

                Label {
                    anchors.fill: parent
                    text: "- 自带边框样式\n- 适合分组显示内容\n- 支持自定义背景\n- 适合作为内容容器"
                    font.pointSize: 10
                    textFormat: Text.MarkdownText
                    wrapMode: Text.WordWrap
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
