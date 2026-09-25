import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "工具栏分隔线"
            description: "ToolSeparator 用于在工具栏中分隔不同功能的按钮组"
        }

        ToolBar {
            Layout.fillWidth: true

            RowLayout {
                anchors.fill: parent
                ToolButton { text: "Act1" }
                ToolButton { text: "Act2" }
                ToolSeparator {}
                ToolButton { text: "Act3" }
                ToolButton { text: "Act4" }
                ToolSeparator {}
                Item {
                    Layout.fillWidth: true
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
