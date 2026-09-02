import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "加载状态"
            description: "监听 Loader 的 status 变化，处理 Null、Loading、Ready、Error 四种状态"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "加载有效组件"
                onClicked: loader.source = "component/ExistingComponent.qml"
            }

            Button {
                text: "加载无效组件"
                onClicked: loader.source = "component/NonExistentComponent.qml"
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

                onStatusChanged: {
                    if (status === Loader.Error) {
                        statusText.color = "#e74c3c"
                    } else if (status === Loader.Ready) {
                        statusText.color = "#2ecc71"
                    } else {
                        statusText.color = "#333"
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.fillWidth: true
            text: {
                switch (loader.status) {
                case Loader.Null: return "组件未加载"
                case Loader.Loading: return "正在加载..."
                case Loader.Ready: return "加载完成"
                case Loader.Error: return "加载错误，无效组件"
                default: return ""
                }
            }
            font.pointSize: 11
            color: "#333"
        }
    }
}
