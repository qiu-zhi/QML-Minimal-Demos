import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义样式 Dial"
            description: "通过自定义 background 和 handle 实现圆环样式与旋转手柄"
        }

        Dial {
            id: control
            Layout.alignment: Qt.AlignHCenter
            width: 140
            height: 140
            from: 0
            to: 10
            stepSize: 0.5
            snapMode: Dial.SnapOnRelease

            background: Rectangle {
                implicitWidth: control.width
                implicitHeight: control.height
                color: "transparent"
                border.color: "#21be2b"
                border.width: 4
                radius: width / 2
            }

            handle: Rectangle {
                id: handleItem
                width: 16
                height: 16
                color: control.pressed ? "#17a81a" : "#21be2b"
                radius: width / 2
                antialiasing: true

                // 计算内部半径：背景半径减去边框宽度和手柄半径
                property real innerRadius: (control.background.width / 2) - control.background.border.width - (width / 2)

                transform: [
                    // 将手柄移动到初始位置（顶部中点）
                    Translate {
                        x: control.background.width / 2 - handleItem.width / 2
                        y: control.background.height / 2 - handleItem.height / 2 - handleItem.innerRadius
                    },
                    // 绕背景中心旋转
                    Rotation {
                        angle: control.angle
                        origin.x: control.background.width / 2
                        origin.y: control.background.height / 2
                    }
                ]
            }
        }

        Text {
            text: "当前值: " + control.value.toFixed(1)
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 10
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
