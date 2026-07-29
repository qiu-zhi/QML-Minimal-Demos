import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础 Dial 控件"
            description: "QML 原生 Dial 旋钮控件，拖动即可调节 0-100 的数值"
        }

        Dial {
            id: control
            Layout.alignment: Qt.AlignHCenter
            width: 140
            height: 140
            from: 0
            to: 100
            value: 50
        }

        Text {
            text: "当前值: " + control.value.toFixed(1)
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 10
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
