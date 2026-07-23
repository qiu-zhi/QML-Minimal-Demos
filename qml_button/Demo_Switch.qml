import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    property bool wifiEnabled: true
    property bool bluetoothEnabled: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Switch - 开关按钮"
            description: "二态切换开关，常用于设置项的启用/禁用"
        }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter
            columns: 2
            rowSpacing: 12
            columnSpacing: 12

            Text { text: qsTr("Wi-Fi:") }
            Switch {
                checked: wifiEnabled
                onClicked: wifiEnabled = !wifiEnabled
            }
            Text { text: qsTr("Bluetooth:") }
            Switch {
                checked: bluetoothEnabled
                onClicked: bluetoothEnabled = !bluetoothEnabled
            }
        }

        Item { Layout.fillHeight: true }
    }
}
