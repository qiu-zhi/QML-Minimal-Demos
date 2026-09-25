import QtQuick

// 展开箭头：SVG 图标，展开时旋转 90°。
// 注意：把它当作自绘的 indicator 用时，内置委托不再自动缩进，x / y 要按 depth 自己算。
Item {
    id: arrow

    property bool expanded: false
    property real iconSize: 14

    implicitWidth: 20
    implicitHeight: 20

    Image {
        anchors.centerIn: parent
        width: arrow.iconSize
        height: arrow.iconSize
        source: "/icons/arrow.svg"
        rotation: arrow.expanded ? 90 : 0
    }
}
