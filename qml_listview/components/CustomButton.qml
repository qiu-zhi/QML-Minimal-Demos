import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: control
    
    property color bgColor: "#2196F3"
    property color textColor: "#ffffff"
    
    implicitWidth: 80
    implicitHeight: 30
    
    background: Rectangle {
        radius: 4
        color: parent.hovered ? Qt.darker(bgColor, 1.1) : bgColor
        border.color: "#dddddd"
        border.width: 1

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    contentItem: Text {
        text: control.text
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 14
    }
} 
