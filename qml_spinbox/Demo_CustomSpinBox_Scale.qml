import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义样式 —— 缩放动画"
            description: "可编辑 SpinBox 配合 DropShadow 阴影，加减号按下时缩放，数值变化时弹出动画"
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            spacing: 10

            SpinBox {
                id: control
                editable: true
                from: 0
                to: 100

                background: Rectangle {
                    implicitWidth: 140
                    implicitHeight: 40
                    radius: height / 2
                    color: control.enabled ? (control.up.pressed || control.down.pressed ? "#eee" : "#fff") : "#f0f0f0"
                    border.color: control.focus ? "#1296ff" : "#ccc"
                    border.width: control.focus ? 2 : 1

                    // 阴影效果
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        color: "#20000000"
                        radius: 4
                        samples: 8
                    }
                }

                up.indicator: Rectangle {
                    x: parent.width - width
                    implicitWidth: 40
                    implicitHeight: 40
                    radius: height / 2
                    color: control.up.pressed ? "#eee" : "transparent"

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

                    // 点击时的缩放动画
                    scale: control.up.pressed ? 0.9 : 1.0
                    Behavior on scale { NumberAnimation { duration: 100 } }
                }

                down.indicator: Rectangle {
                    x: 0
                    implicitWidth: 40
                    implicitHeight: 40
                    radius: height / 2
                    color: control.down.pressed ? "#eee" : "transparent"

                    // 使用 Rectangle 实现减号
                    Rectangle {
                        x: (parent.width - width) / 2
                        y: (parent.height - height) / 2
                        width: parent.width / 3
                        height: 2
                        color: enabled ? "#666" : "#999"
                    }

                    // 点击时的缩放动画
                    scale: control.down.pressed ? 0.9 : 1.0
                    Behavior on scale { NumberAnimation { duration: 100 } }
                }

                contentItem: TextInput {
                    id: textInput
                    text: control.textFromValue(control.value, control.locale)
                    font.pointSize: 11
                    color: "#333"
                    selectionColor: "#1296ff"
                    selectedTextColor: "#fff"
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    readOnly: !control.editable
                    validator: control.validator
                    inputMethodHints: Qt.ImhFormattedNumbersOnly

                    // 数值改变时的动画：弹出并改变透明度
                    Behavior on text {
                        SequentialAnimation {
                            NumberAnimation { target: textInput; property: "scale"; from: 1.0; to: 1.2; duration: 50; easing.type: Easing.OutQuad }
                            NumberAnimation { target: textInput; property: "scale"; from: 1.2; to: 1.0; duration: 150; easing.type: Easing.OutBack }
                        }
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：加减号按下时缩放至 0.9 倍，数值变化时弹出放大再回弹"
        }

        Item { Layout.fillHeight: true }
    }
}
