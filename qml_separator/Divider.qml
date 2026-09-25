import QtQuick

Rectangle {
    property bool isVertical: false
    property color dividerColor: "#d5d5d5"
    property int dividerWidth: 1

    implicitWidth: isVertical ? dividerWidth : parent ? parent.width : 1
    implicitHeight: isVertical ? (parent ? parent.height : 1) : dividerWidth
    color: dividerColor
}
