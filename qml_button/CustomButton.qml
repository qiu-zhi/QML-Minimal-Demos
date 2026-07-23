import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 按钮组件
Button {
    property string buttonText: ""
    property alias description: descText.text
    property color bgColor: "#3498db"

    Layout.fillWidth: true
    Layout.preferredHeight: 60

    // 背景框
    background: Rectangle {
        border.color: "#c0c0c0"
        border.width: 1
        radius: 8

        color: {
            if (pressed) return bgColor.darker(1.1);
            if (hovered) return bgColor.lighter(1.1);
            return bgColor;
        }
    }

    contentItem: Item {
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 4

            Text {
                text: buttonText
                font.pointSize: 12
                font.bold: true
                color: "white"
            }

            Text {
                id: descText
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: 10
                color: "white"
            }
        }
    }
}
