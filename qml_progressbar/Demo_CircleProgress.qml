import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "环形进度条"
            description: "基于 Canvas 2D 绘制环形进度，支持不确定模式下的旋转动画"
        }

        CircleProgress {
            id: control
            Layout.preferredWidth: 220
            Layout.preferredHeight: 220
            Layout.alignment: Qt.AlignHCenter
        }

        Timer {
            id: timer
            interval: 1500
            running: true
            repeat: true
            onTriggered: {
                control.indeterminate = !control.indeterminate
            }
        }

        Item { Layout.fillHeight: true }
    }
}
