import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Push对象"
            description: "演示 StackView 三种 push 方式：Item、Component、URL"
        }

        StackView {
            id: stack
            initialItem: mainView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15
            clip: true
        }
    }

    Component {
        id: mainView

        ColumnLayout {
            spacing: 10

            property color textColor: "#333"

            Button {
                text: "Push Item"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                onClicked: {
                    var info = {"textColor":"#3498db", "textTitle":"Push Item", "textInfo":"用于测试【Push Item】, 调用StackView - push" }
                    var page = stack.push(stackItem, info)
                    page.popClicked.connect(slotPopItem)
                }
            }

            Button {
                text: "Push Component"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                onClicked: {
                    var info = {"textColor":"#e74c3c", "textTitle":"Push Component", "textInfo":"用于测试【Component】, 调用Qt.createComponent()" }
                    var com = Qt.createComponent(Qt.resolvedUrl("PushItem.qml"))
                    if (com.status === Component.Ready) {
                        var page = stack.push(com, info)
                        page.popClicked.connect(slotPopItem)
                    }
                }
            }

            Button {
                text: "Push URL"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                onClicked: {
                    // 通过 URL 加载 PushItem.qml
                    var info = {"textColor":"#2ecc71", "textTitle":"Push URL", "textInfo":"用于测试【Push URL】- Qt.resolvedUrl" }
                    var page = stack.push(Qt.resolvedUrl("PushItem.qml"), info)
                    page.popClicked.connect(slotPopItem)
                }
            }

            Item { Layout.fillHeight: true }
        }
    }

    PushItem {
        id: stackItem
        visible: false
    }

    function slotPopItem() {
        stack.pop()
    }
}
