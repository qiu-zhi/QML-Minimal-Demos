import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: root
    property color bgColor: "#2196F3"
    property color bgColorPressed: "#1976D2"
    property color bgColorDisabled: "#E3F2FD"

    height: 40
    font.pixelSize: 13

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        color: root.enabled ? (root.pressed ? root.bgColorPressed : root.bgColor) : root.bgColorDisabled
        radius: 4
    }

    contentItem: Text {
        text: root.text
        font.pixelSize: root.font.pixelSize
        color: root.enabled ? "white" : "#90CAF9"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
