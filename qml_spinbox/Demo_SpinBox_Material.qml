import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义样式 —— Material"
            description: "使用 Material 风格的 Ripple 涟漪反馈与 MaterialTextContainer 描边背景"
        }

        SpinBox {
            id: control
            spacing: 6
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20

            validator: IntValidator {
                locale: control.locale.name
                bottom: Math.min(control.from, control.to)
                top: Math.max(control.from, control.to)
            }

            contentItem: TextInput {
                text: control.displayText

                font: control.font
                color: enabled ? control.Material.foreground : control.Material.hintTextColor
                selectionColor: control.Material.textSelectionColor
                selectedTextColor: control.Material.foreground

                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                cursorDelegate: CursorDelegate { }

                readOnly: !control.editable
                validator: control.validator
                inputMethodHints: control.inputMethodHints
                clip: width < implicitWidth
            }

            up.indicator: Item {
                x: control.mirrored ? 0 : control.width - width
                implicitWidth: control.Material.touchTarget
                implicitHeight: control.Material.touchTarget
                height: control.height
                width: height

                Ripple {
                    clipRadius: 2
                    x: control.spacing
                    y: control.spacing
                    width: parent.width - 2 * control.spacing
                    height: parent.height - 2 * control.spacing
                    pressed: control.up.pressed
                    active: control.up.pressed || control.up.hovered || control.visualFocus
                    color: control.Material.rippleColor
                }

                // 使用 Rectangle 实现加号
                Rectangle {
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
                    width: Math.min(parent.width / 3, parent.height / 3)
                    height: 2
                    color: enabled ? control.Material.foreground : control.Material.spinBoxDisabledIconColor
                }
                Rectangle {
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
                    width: 2
                    height: Math.min(parent.width / 3, parent.height / 3)
                    color: enabled ? control.Material.foreground : control.Material.spinBoxDisabledIconColor
                }
            }

            down.indicator: Item {
                x: control.mirrored ? control.width - width : 0
                implicitWidth: control.Material.touchTarget
                implicitHeight: control.Material.touchTarget
                height: control.height
                width: height

                Ripple {
                    clipRadius: 2
                    x: control.spacing
                    y: control.spacing
                    width: parent.width - 2 * control.spacing
                    height: parent.height - 2 * control.spacing
                    pressed: control.down.pressed
                    active: control.down.pressed || control.down.hovered || control.visualFocus
                    color: control.Material.rippleColor
                }

                // 使用 Rectangle 实现减号
                Rectangle {
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
                    width: parent.width / 3
                    height: 2
                    color: enabled ? control.Material.foreground : control.Material.spinBoxDisabledIconColor
                }
            }

            background: MaterialTextContainer {
                implicitWidth: 140
                implicitHeight: control.Material.textFieldHeight

                outlineColor: (enabled && control.hovered) ? control.Material.primaryTextColor : control.Material.hintTextColor
                focusedOutlineColor: control.Material.accentColor
                controlHasActiveFocus: control.activeFocus
                controlHasText: true
                horizontalPadding: control.Material.textFieldHorizontalPadding
            }
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：使用 Ripple 涟漪反馈与 MaterialTextContainer 描边背景"
        }

        Item { Layout.fillHeight: true }
    }
}
