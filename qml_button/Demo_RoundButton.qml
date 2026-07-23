import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "RoundButton - 圆形按钮"
            description: "圆形按钮，常用于图标操作，可显示悬浮提示"
        }

        RoundButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 64
            Layout.preferredHeight: 64
            icon.source: "qrc:/icons/file.png"
            icon.width: 36
            icon.height: 36
            ToolTip.visible: hovered
            ToolTip.text: "新建文件"
            onClicked: textResult.text = "点击了新建按钮"
        }

        Text {
            id: textResult
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
