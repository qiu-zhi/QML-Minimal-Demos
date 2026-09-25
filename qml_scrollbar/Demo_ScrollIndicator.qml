import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ScrollIndicator 指示器"
            description: "ScrollIndicator 仅作视觉指示，不可交互，适用于只读场景"
        }

        Flickable {
            id: flickable
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true  // 防止内容超出边界

            contentWidth: contentRect.width
            contentHeight: contentRect.height

            // 与ScrollBar的区别是不可交互，仅提供视觉指示，
            // ScrollIndicator不能用在ScrollView中，
            // 否则报错：ScrollIndicator must be attached to a Flickable.
            ScrollIndicator.vertical: ScrollIndicator {
                contentItem: Rectangle {
                    implicitWidth: 6
                    color: "#ccc"
                    radius: 3
                }
            }

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
