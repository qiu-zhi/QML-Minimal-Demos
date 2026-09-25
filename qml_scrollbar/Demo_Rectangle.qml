import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ScrollBar 手动控制"
            description: "通过 ScrollBar.position 手动控制内容偏移，实现自定义滚动逻辑"
        }

        Rectangle {
            id: frame
            Layout.fillWidth: true
            Layout.fillHeight: true
            border.width: 1
            border.color: "#ccc"
            clip: true

            Text {
                id: content
                text: "ScrollBar In Rectangle"
                font.pixelSize: frame.height
                x: -hbar.position * width
                y: -vbar.position * height
                rightPadding: 20
                bottomPadding: 20
            }

            ScrollBar {
                id: vbar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: frame.height / content.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 1
            }

            ScrollBar {
                id: hbar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Horizontal
                size: frame.width / content.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 1
            }
        }
    }
}
