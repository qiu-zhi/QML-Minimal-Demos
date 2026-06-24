import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            text: "Qt.Dialog - 对话框窗口"
            font.pointSize: 16
            font.bold: true
            color: "#333"
        }

        Text {
            text: "演示 Qt.Dialog 标志位：对话框样式窗口，可模态或非模态"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
        }

        Button {
            text: "打开 Qt.Dialog 窗口"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: dialogWindow.visible = true
        }

        Item { Layout.fillHeight: true }
    }

    Window {
        id: dialogWindow
        title: "Qt.Dialog"
        width: 300
        height: 200
        flags: Qt.Dialog
        color: "#607D8B"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.Dialog"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "对话框样式窗口\n可模态或非模态"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
