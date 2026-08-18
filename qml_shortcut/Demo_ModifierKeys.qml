import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "修饰键组合"
            description: "演示 Ctrl / Shift / Alt 与方向键的组合，实现不同维度的导航操作"
        }

        // Ctrl + 方向键：移动方块
        Shortcut {
            sequence: "Ctrl+Left"
            onActivated: { box.x = Math.max(0, box.x - 20); logText.text = "Ctrl+Left - 左移" }
        }
        Shortcut {
            sequence: "Ctrl+Right"
            onActivated: { box.x = Math.min(canvas.width - box.width, box.x + 20); logText.text = "Ctrl+Right - 右移" }
        }
        Shortcut {
            sequence: "Ctrl+Up"
            onActivated: { box.y = Math.max(0, box.y - 20); logText.text = "Ctrl+Up - 上移" }
        }
        Shortcut {
            sequence: "Ctrl+Down"
            onActivated: { box.y = Math.min(canvas.height - box.height, box.y + 20); logText.text = "Ctrl+Down - 下移" }
        }

        // Shift + 方向键：缩放
        Shortcut {
            sequence: "Shift+Up"
            onActivated: { box.scale = Math.min(2.0, box.scale + 0.1); logText.text = "Shift+Up - 放大" }
        }
        Shortcut {
            sequence: "Shift+Down"
            onActivated: { box.scale = Math.max(0.3, box.scale - 0.1); logText.text = "Shift+Down - 缩小" }
        }

        // Alt + 方向键：旋转
        Shortcut {
            sequence: "Alt+Left"
            onActivated: { box.rotation -= 15; logText.text = "Alt+Left - 逆时针旋转" }
        }
        Shortcut {
            sequence: "Alt+Right"
            onActivated: { box.rotation += 15; logText.text = "Alt+Right - 顺时针旋转" }
        }

        // 操作画布
        Rectangle {
            id: canvas
            Layout.alignment: Qt.AlignHCenter
            width: 440
            height: 220
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            Rectangle {
                id: box
                width: 60
                height: 60
                radius: 8
                color: "#1296FF"
                x: canvas.width / 2 - 30
                y: canvas.height / 2 - 30

                Behavior on scale { NumberAnimation { duration: 100 } }
                Behavior on rotation { NumberAnimation { duration: 100 } }

                Text {
                    anchors.centerIn: parent
                    text: "box"
                    color: "white"
                    font.bold: true
                    font.pointSize: 11
                }
            }

            Text {
                anchors.bottom: canvas.bottom
                anchors.horizontalCenter: canvas.horizontalCenter
                anchors.bottomMargin: 8
                text: "x: " + Math.round(box.x) + "  y: " + Math.round(box.y) +
                      "  scale: " + box.scale.toFixed(1) + "  rotation: " + Math.round(box.rotation) + "°"
                font.pointSize: 10
                color: "#999"
            }
        }

        // 修饰键提示
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Repeater {
                model: [
                    { mod: "Ctrl", keys: "↑ ↓ ← →", action: "移动", color: "#1296FF" },
                    { mod: "Shift", keys: "↑ ↓", action: "缩放", color: "#21be2b" },
                    { mod: "Alt", keys: "← →", action: "旋转", color: "#FF9800" }
                ]
                delegate: Rectangle {
                    width: 120
                    height: 60
                    radius: 8
                    color: Qt.lighter(modelData.color, 1.1)
                    border.color: Qt.darker(modelData.color, 1.05)
                    border.width: 1

                    Column {
                        anchors.centerIn: parent
                        spacing: 2

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.mod + " + " + modelData.keys
                            font.pointSize: 11
                            font.bold: true
                            color: Qt.darker(modelData.color, 1.6)
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.action
                            font.pointSize: 9
                            color: Qt.darker(modelData.color, 1.3)
                        }
                    }
                }
            }
        }

        Text {
            id: logText
            Layout.alignment: Qt.AlignHCenter
            text: "使用 Ctrl/Shift/Alt + 方向键操作方块"
            font.pointSize: 12
            color: "#999"
        }

        Item { Layout.fillHeight: true }
    }
}
