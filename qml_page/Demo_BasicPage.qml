import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Page 基础用法"
            description: "Page 组件包含 header、footer 和内容区域，常作为顶层容器"
        }

        Page {
            Layout.fillWidth: true
            Layout.fillHeight: true

            header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton { text: "菜单" }
                    ToolButton { text: "编辑" }
                    ToolButton { text: "设置" }
                    Item { Layout.fillWidth: true }
                }
            }

            footer: TabBar {
                TabButton { text: "首页" }
                TabButton { text: "发现" }
                TabButton { text: "我的" }
            }

            Rectangle {
                anchors.fill: parent
                color: "#f5f5f5"

                Text {
                    anchors.centerIn: parent
                    text: "Page 内容区域"
                    font.pointSize: 14
                    color: "#666"
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
