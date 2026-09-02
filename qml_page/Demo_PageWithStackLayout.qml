import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Page 与 StackLayout"
            description: "通过 StackLayout 在多个 Page 之间切换，按钮高亮显示当前页"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 5

            Repeater {
                model: ["首页", "列表", "详情"]

                Button {
                    text: modelData
                    highlighted: stackLayout.currentIndex === index
                    onClicked: stackLayout.currentIndex = index
                }
            }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true

            // 说明：StackLayout 不做页面标题渲染，当前页由上方按钮高亮指示，
            // 故这里不设置 Page.title（title 只对能读取它的宿主有意义）
            Page {
                Label {
                    anchors.centerIn: parent
                    text: "首页页面"
                    font.pointSize: 14
                }
            }

            Page {
                ListView {
                    anchors.fill: parent
                    clip: true
                    model: 5
                    delegate: ItemDelegate {
                        text: "列表项 " + (index + 1)
                    }
                }
            }

            Page {
                Label {
                    anchors.centerIn: parent
                    text: "详情页面（索引 " + stackLayout.currentIndex + "）"
                    font.pointSize: 14
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
