import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "批量操作"
            description: "StackView 的批量 push、批量 pop 和清空栈操作"
        }

        StackView {
            id: stack
            initialItem: mainView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15
            clip: true
        }

        Text {
            text: "StackView Depth: " + stack.depth
            color: "#333"
            font.pointSize: 11
        }
    }

    Component {
        id: mainView

        ColumnLayout {
            spacing: 10

            property color textColor: "#333"

            Button {
                text: "批量Push（5个页面）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                enabled: stack.depth < 30
                onClicked: {
                    var items = []
                    for (var i = 1; i <= 5; i++) {
                        items.push(mainView, {"textColor":"green"})
                    }
                    stack.pushItems(items)
                }
            }

            Button {
                text: "批量Pop（5个页面）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                enabled: stack.depth > 1
                onClicked: {
                    var popCount = Math.min(5, stack.depth - 1)
                    for (var i = 0; i < popCount; i++) {
                        stack.pop()
                    }
                }
            }

            Button {
                text: "清空栈（Pop全部）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                enabled: stack.depth > 1
                onClicked: {
                    while (stack.depth > 1) {
                        stack.pop()
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
