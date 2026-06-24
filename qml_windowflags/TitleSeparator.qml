import QtQuick
import QtQuick.Layouts

ColumnLayout {
    property alias title: titleText.text
    property alias description: descText.text

    width: parent.width
    spacing: 8

    Text {
        id: titleText
        font.pointSize: 16
        font.bold: true
        color: "#333"
    }

    Rectangle {
        Layout.fillWidth: true
        height: 2
        color: "#1296FF"
    }

    Text {
        id: descText
        font.pointSize: 10
        color: "#666"
        wrapMode: Text.WordWrap
        visible: text.length > 0
    }

    Item { height: 4 }
}
