import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "切换组件"
            description: "通过条件表达式在两个 sourceComponent 之间切换，实现动态组件切换"
        }

        Switch {
            id: controlSwitch
            text: "切换组件"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Qt.rgba(0.95, 0.95, 0.95, 1)
            radius: 4

            Loader {
                anchors.fill: parent
                anchors.margins: 10
                sourceComponent: controlSwitch.checked ? component1 : component2
            }
        }

        Text {
            text: "当前: " + (controlSwitch.checked ? "组件 1（红色）" : "组件 2（蓝色）")
            font.pointSize: 11
            color: "#666"
        }
    }

    Component {
        id: component1
        Rectangle {
            color: "#e74c3c"
            radius: 6

            Text {
                anchors.centerIn: parent
                text: "组件 1"
                color: "#fff"
                font.pointSize: 16
                font.bold: true
            }
        }
    }

    Component {
        id: component2
        Rectangle {
            color: "#3498db"
            radius: 6

            Text {
                anchors.centerIn: parent
                text: "组件 2"
                color: "#fff"
                font.pointSize: 16
                font.bold: true
            }
        }
    }
}
