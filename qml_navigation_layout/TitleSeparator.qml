import QtQuick
import QtQuick.Layouts

ColumnLayout {
    property alias title: titleText.text
    property alias description: descText.text

    // 作为其它布局的子项时自动横向填满，避免在布局里直接写 width
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

    Item {
        Layout.preferredHeight: 4
    }
}
