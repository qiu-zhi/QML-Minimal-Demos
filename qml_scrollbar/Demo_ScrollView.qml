import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ScrollView 滚动"
            description: "使用 ScrollView 包装可滚动内容，自动管理滚动条"
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.vertical.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.interactive: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10

                Repeater {
                    model: 20
                    delegate: ItemDelegate {
                        background: Rectangle {
                            implicitWidth: 150
                            implicitHeight: 25
                            color: "#3498db"
                            radius: 4
                        }
                        contentItem: Text {
                            text: "This is Scroll Item " + index
                            color: "#fff"
                        }
                    }
                }
            }
        }
    }
}
