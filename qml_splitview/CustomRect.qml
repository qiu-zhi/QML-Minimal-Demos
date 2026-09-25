import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    implicitWidth: 64
    implicitHeight: 64
    color: Theme.rectNumStyle.bg

    property color rectColor: Theme.rectNumStyle.rectColor
    property string rectNum: "1"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Rectangle {
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            color: root.rectColor
            radius: 18

            Text {
                text: root.rectNum
                font.pointSize: 11
                font.bold: true
                color: Theme.rectNumStyle.numColor
                anchors.centerIn: parent
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            text: "面板 " + root.rectNum
            font.pointSize: 10
            color: Theme.rectNumStyle.textColor
        }
    }
}
