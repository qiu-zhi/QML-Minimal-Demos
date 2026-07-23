import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic.impl
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义 BusyIndicator - 原生实现"
            description: "使用 QtQuick.Controls.Basic.impl 中的 BusyIndicatorImpl 原生组件"
        }

        BusyIndicator {
            id: control
            running: true
            Layout.alignment: Qt.AlignHCenter

            contentItem: BusyIndicatorImpl {
                implicitWidth: 120
                implicitHeight: 120

                pen: "#fff"
                fill: "#3498db"

                running: control.running
                opacity: control.running ? 1 : 0
                Behavior on opacity { OpacityAnimator { duration: 250 } }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
