import QtQuick
import QtQuick.Layouts

// 页面标题 + 蓝色分隔线 + 说明文字
ColumnLayout {
    property alias title: titleText.text
    property alias description: descText.text

    Layout.fillWidth: true
    spacing: 8

    Text {
        id: titleText
        font.pointSize: 16
        font.bold: true
        color: "#333"
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 2
        color: "#1296FF"
    }

    Text {
        id: descText
        Layout.fillWidth: true
        font.pointSize: 10
        color: "#666"
        wrapMode: Text.Wrap
        visible: text.length > 0
    }
}
