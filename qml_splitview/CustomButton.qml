import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: root
    text: ""
    implicitWidth: 80
    implicitHeight: 30

    property color bgNormal: Theme.buttonStyle.bgNormal
    property color bgPressed: Theme.buttonStyle.bgPressed
    property color bgDisabled: Theme.buttonStyle.bgDisabled
    property color textNormal: Theme.buttonStyle.textNormal
    property color borderColor: Theme.buttonStyle.borderColor

    background: Rectangle {
        color: root.enabled ? (root.pressed ? root.bgPressed : root.bgNormal) : root.bgDisabled
        border.color: root.borderColor
        radius: 6
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    contentItem: Text {
        text: root.text
        font.pointSize: 10
        color: root.textNormal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
