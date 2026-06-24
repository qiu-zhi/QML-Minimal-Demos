import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Popup 弹窗"
            description: "演示 Popup 组件的基本用法：轻量级弹出层，常用于菜单、提示"
        }

        Button {
            text: "打开 Popup"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: popup.open()
        }

        Item { Layout.fillHeight: true }
    }

    Popup {
        id: popup
        parent: Overlay.overlay
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 250
        height: 120
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: "white"
            radius: 8
            border.color: "#ddd"
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

            Text {
                text: "这是一个 Popup"
                font.pointSize: 12
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "点击外部或按 Esc 关闭"
                font.pointSize: 10
                color: "#666"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
