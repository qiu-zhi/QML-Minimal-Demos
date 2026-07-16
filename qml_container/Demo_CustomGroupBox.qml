import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义 GroupBox"
            description: "通过 background 和 label 属性自定义 GroupBox 外观"
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 15

            GroupBox {
                id: control
                title: "自定义GroupBox容器"
                Layout.fillWidth: true
                Layout.preferredHeight: 120

                background: Rectangle {
                    y: control.topPadding - control.bottomPadding
                    width: parent.width
                    height: parent.height - control.topPadding + control.bottomPadding
                    color: "transparent"
                    border.color: "#ccc"
                    radius: 4
                }

                label: Label {
                    x: control.leftPadding
                    width: control.availableWidth
                    text: control.title
                    elide: Text.ElideRight
                }

                Label {
                    anchors.fill: parent
                    text: "- 通过 background 自定义边框样式\n- 通过 label 自定义标题外观\n- 适合需要特殊样式的场景"
                    font.pointSize: 10
                    textFormat: Text.MarkdownText
                    wrapMode: Text.WordWrap
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
