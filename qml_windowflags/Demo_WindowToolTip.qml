import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Qt.ToolTip - 提示窗口"
            description: "演示 Qt.ToolTip 标志位：无边框浮动提示窗口，点击任意位置关闭"
        }

        Button {
            text: "打开 Qt.ToolTip 窗口"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: tooltipWindow.visible = true
        }

        Item { Layout.fillHeight: true }
    }

    Window {
        id: tooltipWindow
        width: 250
        height: 100
        flags: Qt.ToolTip
        color: "#4CAF50"

        MouseArea {
            anchors.fill: parent
            onClicked: tooltipWindow.close()
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.ToolTip"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "无边框浮动提示窗口\n点击任意位置关闭"
                font.pointSize: 11
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
