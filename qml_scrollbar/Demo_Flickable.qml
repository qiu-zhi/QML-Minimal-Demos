import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Flickable 双向滚动"
            description: "在 Flickable 中同时附加垂直和水平 ScrollBar，实现双向滚动"
        }

        Flickable {
            id: flickable
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true  // 防止内容超出边界

            contentWidth: contentRect.width
            contentHeight: contentRect.height

            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AlwaysOn }
            ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AlwaysOn }

            Rectangle {
                id: contentRect
                width: 500
                height: 500
                color: "#3498db"
                Text {
                    text: "Scrollable Content"
                    anchors.centerIn: parent
                    font.pointSize: 20
                    color: "#fff"
                }
            }
        }
    }
}
