import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

TextField {
    id: control
    implicitWidth: 250
    implicitHeight: 30
    placeholderText: "自定义样式文本框"

    // 背景样式
    background: Rectangle {
        color: control.enabled ? "#fff" : "#f5f5f5"
        border.color: control.activeFocus ? "#3498db" : control.hovered ? "#999" : "#ccc"
        border.width: control.activeFocus ? 2 : 1
        radius: 4
    }

    // 文本样式
    color: "#333"
    selectionColor: "#3498db"
    selectedTextColor: "#fff"
    font.pointSize: 10
    leftPadding: 10
    rightPadding: 10
}
