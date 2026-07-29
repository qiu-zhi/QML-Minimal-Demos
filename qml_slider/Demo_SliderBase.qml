import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Slider 基础"
            description: "QML Slider 组件的基本用法，支持水平/垂直方向切换"
        }

        Slider {
            id: control
            Layout.fillWidth: true
            Layout.preferredHeight: 76

            from: 0
            to: 100
            value: 50
            stepSize: 5
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 15

            Switch {
                text: "垂直方向"
                font.pointSize: 10
                checked: control.orientation === Qt.Vertical
                onClicked: {
                    control.orientation === Qt.Vertical ?
                                control.orientation = Qt.Horizontal :
                                control.orientation = Qt.Vertical;
                }
            }

            Text {
                text: "当前值: " + control.value
                font.pointSize: 10
            }
        }

        Item { Layout.fillHeight: true }
    }
}
