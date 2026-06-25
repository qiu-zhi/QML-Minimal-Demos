import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "GroupBox 容器"
            description: "带有标题的分组框，适合组织相关控件"
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 15

            GroupBox {
                title: "GroupBox容器"
                Layout.fillWidth: true
                Layout.preferredHeight: 120

                Label {
                    anchors.fill: parent
                    text: "- 带有标题的分组框\n- 适合组织相关控件"
                    font.pointSize: 10
                    textFormat: Text.MarkdownText
                    wrapMode: Text.WordWrap
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
