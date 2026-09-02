import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "过渡效果"
            description: "自定义 StackView 的 pushEnter / pushExit / popEnter / popExit 过渡动画"
        }

        StackView {
            id: stack
            initialItem: mainView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15
            clip: true

            pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 300
                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 300
                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 300
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 300
                }
            }
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
                text: "Push（叠加新页面）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                property var info: {"textColor":"green"}
                onClicked: stack.push(mainView, info)
            }

            Button {
                text: "Pop（回到上一页）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                enabled: stack.depth > 1
                onClicked: stack.pop()
            }

            Item { Layout.fillHeight: true }
        }
    }
}
