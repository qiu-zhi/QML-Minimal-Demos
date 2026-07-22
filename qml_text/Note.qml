import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root
    property alias text: noteText.text
    property int delay: 0

    spacing: 4
    Layout.fillWidth: true

    Text {
        id: noteText
        font.pointSize: 10
        color: "#333"
        textFormat: Text.MarkdownText
    }
}
