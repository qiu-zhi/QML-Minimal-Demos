import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {

    property string description: ""

    ColumnLayout {
        anchors.fill: parent

        Text {
            Layout.alignment: Qt.AlignCenter
            text: description
            font.pointSize: 20
            font.bold: true
        }
    }
}
