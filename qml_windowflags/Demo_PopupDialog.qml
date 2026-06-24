import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            text: "Dialog 对话框"
            font.pointSize: 16
            font.bold: true
            color: "#333"
        }

        Text {
            text: "演示 Dialog 组件：标准对话框，支持模态和标准按钮（Ok/Cancel）"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
        }

        Button {
            text: "打开 Dialog"
            onClicked: dialog.open()
        }

        Text {
            id: resultText
            text: ""
            font.pointSize: 11
            color: "#1976D2"
        }

        Item { Layout.fillHeight: true }
    }

    Dialog {
        id: dialog
        title: "确认操作"
        modal: true
        anchors.centerIn: parent
        standardButtons: Dialog.Ok | Dialog.Cancel

        Label {
            text: "你确定要执行此操作吗？"
            font.pointSize: 12
        }

        onAccepted: resultText.text = "用户点击了：确定"
        onRejected: resultText.text = "用户点击了：取消"
    }
}
