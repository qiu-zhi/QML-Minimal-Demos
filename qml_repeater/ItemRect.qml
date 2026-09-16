import QtQuick
import QtQuick.Layouts

Rectangle {

    property color itemColor: "#333"
    property string itemText: ""
    property string itemDes: ""

    Layout.fillWidth: true
    Layout.preferredHeight: 25
    radius: 6
    color: "#f5f5f5"
    border.color: "#ccc"
    border.width: 1

    Text {
        anchors.centerIn: parent
        text: itemText + " - " + itemDes
        color: itemColor
        font.pointSize: 10
        font.bold: true
    }
}
