import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Qt.WindowStaysOnTopHint - 置顶窗口"
            description: "演示 Qt.WindowStaysOnTopHint 标志位：始终在最上层窗口，不会被其他窗口覆盖"
        }

        Button {
            text: "打开 Qt.StayOnTop 窗口"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: topWindow.visible = true
        }

        Item { Layout.fillHeight: true }
    }

    Window {
        id: topWindow
        title: "置顶窗口"
        width: 300
        height: 200
        flags: Qt.WindowStaysOnTopHint
        color: "#F44336"

        // 关闭按钮
        Rectangle {
            width: 30
            height: 30
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 5
            color: topCloseArea.containsMouse ? "#E91E63" : "transparent"
            radius: 4

            Text {
                anchors.centerIn: parent
                text: "✕"
                color: "white"
                font.pointSize: 12
            }

            MouseArea {
                id: topCloseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: topWindow.close()
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.WindowStaysOnTopHint"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "始终在最上层窗口\n不会被其他窗口覆盖"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
