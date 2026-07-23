import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "BusyIndicator 基本用法"
            description: "通过按钮控制 BusyIndicator 的 running 属性，演示加载状态切换"
        }

        Column {
            spacing: 15
            Layout.alignment: Qt.AlignHCenter

            Button {
                text: busyIndicator.running ? "Stop Loading" : "Start Loading"
                onClicked: busyIndicator.running = !busyIndicator.running
            }

            BusyIndicator {
                id: busyIndicator
                running: false
                width: 120
                height: 120
            }
        }

        Item { Layout.fillHeight: true }
    }
}
