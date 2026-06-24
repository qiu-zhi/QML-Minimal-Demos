import QtQuick
import QtQuick.Layouts

ColumnLayout {
    property alias title: titleText.text

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
        color: "#1976D2"
    }

    Item { height: 4 }
}
