import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Dialog 对话框"
            description: "演示 Dialog 组件：标准对话框，支持模态和标准按钮（Ok/Cancel）"
        }

        Button {
            text: "打开 Dialog"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
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
