import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

TextField {
    id: root
    property string iconSource: ""

    leftPadding: 40
    rightPadding: 10
    implicitHeight: 40
    font.pixelSize: 13
    verticalAlignment: Text.AlignVCenter

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        color: "white"
        border.color: root.activeFocus ? "#2196F3" : "#ddd"
        border.width: root.activeFocus ? 2 : 1
        radius: 6
        clip: true

        Image {
            id: iconImage
            source: root.iconSource
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 20
            height: 20
        }
    }
}
