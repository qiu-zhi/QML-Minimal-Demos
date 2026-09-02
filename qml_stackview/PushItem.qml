import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    width: 250
    height: 250
    border.color: "#ccc"
    border.width: 0
    radius: 6
    visible: false

    property color textColor: "#333"
    property string textTitle: ""
    property string textInfo: ""
    signal popClicked

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 15

        Text {
            text: textTitle
            color: textColor
            font.pointSize: 13
            font.bold: true
        }

        Text {
            text: textInfo
            color: textColor
            font.pointSize: 11
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            wrapMode: Text.Wrap
        }

        RoundButton {
            text: "Pop"
            Layout.preferredWidth: 90
            Layout.preferredHeight: 30
            onClicked: popClicked()
        }

        Item { Layout.fillHeight: true }
    }
}
