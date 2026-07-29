import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义样式 —— Basic"
            description: "使用 Basic 风格完全自定义 background、contentItem、指示器"
        }

        SpinBox {
            id: control
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20

            validator: IntValidator {
                locale: control.locale.name
                bottom: Math.min(control.from, control.to)
                top: Math.max(control.from, control.to)
            }

            contentItem: TextInput {
                z: 2
                text: control.displayText
                clip: width < implicitWidth
                padding: 6

                font: control.font
                color: "#333"
                selectionColor: "#1296ff"
                selectedTextColor: "#fff"

                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !control.editable
                validator: control.validator
                inputMethodHints: control.inputMethodHints

                Rectangle {
                    width: parent.width
                    height: parent.height
                    visible: control.activeFocus
                    color: "transparent"
                    border.color: "#ccc"
                    border.width: 1
                }
            }

            up.indicator: Rectangle {
                x: control.mirrored ? 0 : control.width - width
                height: control.height
                implicitWidth: 40
                implicitHeight: 40
                color: control.up.pressed ? "#ccc" : "#f0f0f0"
                border.color: "#ccc"

                // 使用 Rectangle 实现加号
                Rectangle {
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
                    width: parent.width / 3
                    height: 2
                    color: enabled ? "#666" : "#999"
                }
                Rectangle {
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
                    width: 2
                    height: parent.width / 3
                    color: enabled ? "#666" : "#999"
                }
            }

            down.indicator: Rectangle {
                x: control.mirrored ? parent.width - width : 0
                height: control.height
                implicitWidth: 40
                implicitHeight: 40
                color: control.down.pressed ? "#ccc" : "#f0f0f0"
                border.color: "#ccc"

                // 使用 Rectangle 实现减号
                Rectangle {
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
                    width: parent.width / 3
                    height: 2
                    color: enabled ? "#666" : "#999"
                }
            }

            // 背景色
            background: Rectangle {
                implicitWidth: 140
                color: enabled ? "#fff" : "#999"
                border.color: "#ccc"
            }
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：完全自定义了背景、内容项、加减号指示器四部分"
        }

        Item { Layout.fillHeight: true }
    }
}
