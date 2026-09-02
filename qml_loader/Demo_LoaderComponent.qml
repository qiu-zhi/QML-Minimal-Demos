import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    Component {
        id: com1
        Rectangle {
            width: 100
            height: 100
            color: "#3498db"
            radius: 6

            Text {
                anchors.centerIn: parent
                text: "Component"
                color: "#fff"
                font.pointSize: 12
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "加载 Component 组件"
            description: "使用 sourceComponent 加载内联 Component 对象，可在运行时挂载和卸载"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "加载"
                onClicked: loader.sourceComponent = com1
            }

            Button {
                text: "卸载"
                onClicked: loader.sourceComponent = null
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
                text: loader.item ? "" : "点击「加载」"
                font.pointSize: 11
                color: "#999"
                visible: !loader.item
            }
        }
    }
}
