import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            text: "Qt.Tool - 工具窗口"
            font.pointSize: 16
            font.bold: true
            color: "#333"
        }

        Text {
            text: "演示 Qt.Tool 标志位：窄标题栏工具窗口，任务栏不显示独立图标"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
        }

        Button {
            text: "打开 Qt.Tool 窗口"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: toolWindow.visible = true
        }

        Item { Layout.fillHeight: true }
    }

    Window {
        id: toolWindow
        title: "Qt.Tool"
        width: 300
        height: 200
        flags: Qt.Tool
        color: "#2196F3"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.Tool"
                font.pointSize: 14
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "窄标题栏工具窗口\n任务栏不显示独立图标"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
