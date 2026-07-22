import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    text: ""
    implicitWidth: 80
    implicitHeight: 30

    property color bgColor: "#3498db"
    property color bgDisabled: "#bdc3c7"
    property color textNormal: "#fff"
    property color borderColor: "#ccc"

    background: Rectangle {
        color: {
            if(!enabled) return bgDisabled;
            else if (pressed) return bgColor.darker(1.1);
            else if (hovered) return bgColor.lighter(1.1);
            else return bgColor;
        }

        border.color: borderColor
        radius: 6
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    contentItem: Text {
        text: parent.text
        font.pointSize: 10
        color: textNormal
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
