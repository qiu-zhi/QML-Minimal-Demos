import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Qt.FramelessWindowHint - 无边框窗口"
        }

        Text {
            text: "演示 Qt.FramelessWindowHint 标志位：完全无边框窗口，拖拽任意位置可移动"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
        }

        Button {
            text: "打开 Qt.Frameless 窗口"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: framelessWindow.visible = true
        }

        Item { Layout.fillHeight: true }
    }

    Window {
        id: framelessWindow
        title: "无边框窗口"
        width: 300
        height: 200
        flags: Qt.FramelessWindowHint
        color: "#9C27B0"

        MouseArea {
            anchors.fill: parent
            onPressed: framelessWindow.startSystemMove()
        }

        // 关闭按钮
        Rectangle {
            width: 30
            height: 30
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 5
            color: closeArea.containsMouse ? "#E91E63" : "transparent"
            radius: 4

            Text {
                anchors.centerIn: parent
                text: "✕"
                color: "white"
                font.pointSize: 12
            }

            MouseArea {
                id: closeArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: framelessWindow.close()
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.FramelessWindowHint"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "完全无边框窗口\n拖拽任意位置可移动"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
