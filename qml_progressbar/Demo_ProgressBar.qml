import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ProgressBar 默认样式"
            description: "QtQuick.Controls 提供的原生 ProgressBar，通过 value 属性（0~1）设置当前进度"
        }

        ProgressBar {
            id: control
            Layout.fillWidth: true
            height: 24
            value: 0.6
        }

        Text {
            text: "进度值: " + control.value
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
