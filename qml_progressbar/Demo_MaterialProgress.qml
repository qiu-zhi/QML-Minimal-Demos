import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        TitleSeparator {
            title: "自定义进度条（Material 风格）"
            description: "使用 ProgressBarImpl + Material 主题色实现细条进度条，支持不确定（indeterminate）模式"
        }

        ProgressBar {
            id: control
            Layout.fillWidth: true
            value: 0.6

            contentItem: ProgressBarImpl {
                implicitHeight: 4

                scale: control.mirrored ? -1 : 1
                color: control.Material.accentColor
                progress: control.position
                indeterminate: control.visible && control.indeterminate
            }

            background: Rectangle {
                y: (control.height - height) / 2
                implicitHeight: 4
                color: Qt.rgba(control.Material.accentColor.r, control.Material.accentColor.g, control.Material.accentColor.b, 0.25)
            }
        }

        Switch {
            text: "开启不确定模式"
            font.pointSize: 11
            checked: control.indeterminate
            onClicked: control.indeterminate = !control.indeterminate
        }

        Item { Layout.fillHeight: true }
    }
}
