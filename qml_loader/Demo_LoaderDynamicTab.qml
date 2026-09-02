import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "动态标签页"
            description: "切换 Loader 的 source 在多个 QML 文件之间切换，实现标签页效果"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "页面1"
                onClicked: loader.source = "component/Page1.qml"
            }

            Button {
                text: "页面2"
                onClicked: loader.source = "component/Page2.qml"
            }

            Button {
                text: "页面3"
                onClicked: loader.source = "component/Page3.qml"
            }
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
        }

        Text {
            text: "当前: " + (loader.source ? loader.source.toString().split("/").pop() : "无")
            font.pointSize: 11
            color: "#666"
        }
    }
}
