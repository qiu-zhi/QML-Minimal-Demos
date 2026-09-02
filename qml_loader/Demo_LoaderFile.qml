import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "从文件加载组件"
            description: "通过 source 属性指定 QML 文件路径，动态加载外部组件"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "加载组件"
                onClicked: loader.source = "component/MyComponent.qml"
            }

            Button {
                text: "卸载组件"
                onClicked: loader.source = ""
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

            Text {
                anchors.centerIn: parent
                text: loader.status === Loader.Ready ? "" : "点击「加载组件」"
                font.pointSize: 11
                color: "#999"
                visible: loader.status !== Loader.Ready
            }
        }
    }
}
