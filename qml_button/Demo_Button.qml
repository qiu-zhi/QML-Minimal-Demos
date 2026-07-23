import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Button - 普通按钮"
            description: "基础按钮组件，支持文本、图标、可选中状态及点击事件"
        }

        Button {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 160
            Layout.preferredHeight: 40
            text: "打开文件"
            font.pointSize: 13
            checkable: true
            icon.source: "qrc:/icons/file.png"
            onClicked: textResult.text = "点击了打开按钮"
        }

        Text {
            id: textResult
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
