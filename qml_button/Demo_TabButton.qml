import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "TabButton - 标签按钮"
            description: "TabBar 中的标签按钮，用于多页面切换"
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            Repeater {
                model: ["按钮1", "按钮2", "按钮3", "按钮4", "按钮5"]
                TabButton {
                    text: modelData
                    implicitWidth: 30
                    height: 30
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignLeft
            text: {
                return "选中第" + (tabBar.currentIndex + 1) + "个按钮"
            }
        }

        Item { Layout.fillHeight: true }
    }
}
