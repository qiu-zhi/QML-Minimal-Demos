import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "堆叠效果"
            description: "通过 StackView.index 实现多层堆叠的视觉位移效果"
        }

        StackView {
            id: stack
            Layout.preferredWidth: 250
            Layout.preferredHeight: 200

            property real offset: 10

            initialItem: Component {
                id: page
                Rectangle {
                    property real pos: StackView.index * stack.offset
                    property real hue: Math.random()
                    color: Qt.hsla(hue, 0.5, 0.8, 0.6)
                    border.color: Qt.hsla(hue, 0.5, 0.5, 0.8)
                    StackView.visible: true

                    RowLayout {
                        anchors.centerIn: parent
                        spacing: 10

                        RoundButton {
                            text: "Push"
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 30
                            enabled: stack.depth < 6
                            onClicked: stack.push(page)
                        }

                        RoundButton {
                            text: "Pop"
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 30
                            enabled: stack.depth > 1
                            onClicked: stack.pop()
                        }
                    }
                }
            }

            pushEnter: Transition {
                id: pushEnter
                ParallelAnimation {
                    PropertyAction { property: "x"; value: pushEnter.ViewTransition.item.pos }
                    NumberAnimation { properties: "y"; from: pushEnter.ViewTransition.item.pos + stack.offset; to: pushEnter.ViewTransition.item.pos; duration: 400; easing.type: Easing.OutCubic }
                    NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 400; easing.type: Easing.OutCubic }
                }
            }
            popExit: Transition {
                id: popExit
                ParallelAnimation {
                    PropertyAction { property: "x"; value: popExit.ViewTransition.item.pos }
                    NumberAnimation { properties: "y"; from: popExit.ViewTransition.item.pos; to: popExit.ViewTransition.item.pos + stack.offset; duration: 400; easing.type: Easing.OutCubic }
                    NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 400; easing.type: Easing.OutCubic }
                }
            }

            pushExit: Transition {
                id: pushExit
                PropertyAction { property: "x"; value: pushExit.ViewTransition.item.pos }
                PropertyAction { property: "y"; value: pushExit.ViewTransition.item.pos }
            }
            popEnter: Transition {
                id: popEnter
                PropertyAction { property: "x"; value: popEnter.ViewTransition.item.pos }
                PropertyAction { property: "y"; value: popEnter.ViewTransition.item.pos }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
