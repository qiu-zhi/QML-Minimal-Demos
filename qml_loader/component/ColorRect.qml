import QtQuick

Rectangle {
    width: 50
    height: 50
    radius: 6
    color: Qt.rgba(Math.random(), Math.random(), Math.random(), 0.35)

    MouseArea {
        anchors.fill: parent
        onClicked: parent.destroy()
    }
}
