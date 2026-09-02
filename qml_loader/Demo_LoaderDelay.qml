import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "延迟加载"
            description: "结合 Timer 模拟耗时组件的延迟加载，加载时显示 BusyIndicator"
        }

        Button {
            text: "延迟加载（2秒）"
            Layout.fillWidth: true
            onClicked: {
                busyIndicator.running = true
                delayTimer.start()
            }
        }

        BusyIndicator {
            id: busyIndicator
            running: false
            visible: running
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Qt.rgba(0.95, 0.95, 0.95, 1)
            radius: 4

            Loader {
                id: loader
                anchors.fill: parent
                anchors.margins: 10
            }

            Text {
                anchors.centerIn: parent
                text: "点击上方按钮加载"
                font.pointSize: 11
                color: "#999"
                visible: loader.status !== Loader.Ready
            }
        }
    }

    Timer {
        id: delayTimer
        interval: 2000
        onTriggered: {
            loader.source = "component/HeavyComponent.qml"
            busyIndicator.running = false
        }
    }
}
