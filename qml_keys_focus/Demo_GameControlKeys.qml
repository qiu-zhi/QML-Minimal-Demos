import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "方向键控制"
            description: "使用 Keys.onPressed 处理 WASD 与方向键，按住移动、松开停止；同时按下多键时支持斜向移动。"
        }

        // 游戏场地
        Rectangle {
            id: field
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            focus: true   // 默认获取焦点
            activeFocusOnTab: true

            // 按键状态字典
            property var pressedKeys: ({ up: false, down: false, left: false, right: false })

            // 网格背景
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.strokeStyle = "#EEE"
                    ctx.lineWidth = 1
                    var step = 40
                    ctx.beginPath()
                    for (var x = 0; x <= width; x += step) {
                        ctx.moveTo(x, 0); ctx.lineTo(x, height)
                    }
                    for (var y = 0; y <= height; y += step) {
                        ctx.moveTo(0, y); ctx.lineTo(width, y)
                    }
                    ctx.stroke()
                }
            }

            // 玩家角色
            Rectangle {
                id: player
                width: 32
                height: 32
                radius: 6
                color: "#1296FF"
                x: field.width / 2 - width / 2
                y: field.height / 2 - height / 2
                border.color: "#0A6FCC"
                border.width: 2

                Behavior on x { NumberAnimation { duration: 60 } }
                Behavior on y { NumberAnimation { duration: 60 } }
            }

            // 状态键提示
            Column {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 8
                spacing: 4

                Text {
                    text: field.activeFocus ? "焦点已就绪" : "点击场地获取焦点"
                    font.pointSize: 11
                    color: field.activeFocus ? "#21be2b" : "#999"
                    font.bold: true
                }
                Text {
                    text: "坐标：(" + Math.round(player.x) + ", " + Math.round(player.y) + ")"
                    font.pointSize: 10
                    color: "#666"
                }
            }

            // 按键状态指示器
            Row {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 10
                spacing: 6

                Repeater {
                    model: [
                        { label: "W",     key: "up",    color: "#1296FF" },
                        { label: "A",     key: "left",  color: "#21be2b" },
                        { label: "S",     key: "down",  color: "#FF9800" },
                        { label: "D",     key: "right", color: "#E91E63" }
                    ]
                    delegate: Rectangle {
                        width: 38; height: 38
                        radius: 6
                        color: field.pressedKeys[modelData.key] ? modelData.color : "#EEE"
                        border.color: field.pressedKeys[modelData.key] ? modelData.color : "#ccc"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: modelData.label
                            font.pointSize: 11
                            font.bold: true
                            color: field.pressedKeys[modelData.key] ? "white" : "#999"
                        }
                    }
                }
            }

            Keys.onPressed: (event) => {
                var handled = true
                switch (event.key) {
                    case Qt.Key_W:
                    case Qt.Key_Up:
                        field.pressedKeys.up = true
                        break
                    case Qt.Key_S:
                    case Qt.Key_Down:
                        field.pressedKeys.down = true
                        break
                    case Qt.Key_A:
                    case Qt.Key_Left:
                        field.pressedKeys.left = true
                        break
                    case Qt.Key_D:
                    case Qt.Key_Right:
                        field.pressedKeys.right = true
                        break
                    case Qt.Key_R:
                        // 回到初始位置：先停掉移动定时器，避免其把回位动画读出的中间值写回、打断回位
                        moveTimer.stop()
                        player.x = field.width / 2 - player.width / 2
                        player.y = field.height / 2 - player.height / 2
                        event.accepted = true
                        return   // 提前返回，不启动移动定时器
                    default:
                        handled = false
                }
                if (handled) {
                    event.accepted = true
                    // 触发按键状态指示器更新（强制 binding 刷新）
                    field.pressedKeys = field.pressedKeys
                    moveTimer.start()
                }
            }

            Keys.onReleased: (event) => {
                var handled = true
                switch (event.key) {
                    case Qt.Key_W:
                    case Qt.Key_Up:
                        field.pressedKeys.up = false
                        break
                    case Qt.Key_S:
                    case Qt.Key_Down:
                        field.pressedKeys.down = false
                        break
                    case Qt.Key_A:
                    case Qt.Key_Left:
                        field.pressedKeys.left = false
                        break
                    case Qt.Key_D:
                    case Qt.Key_Right:
                        field.pressedKeys.right = false
                        break
                    default:
                        handled = false
                }
                if (handled) {
                    event.accepted = true
                    field.pressedKeys = field.pressedKeys
                    // 没有任何方向键被按下时停止定时器
                    if (!field.pressedKeys.up && !field.pressedKeys.down &&
                        !field.pressedKeys.left && !field.pressedKeys.right) {
                        moveTimer.stop()
                    }
                }
            }

            // 移动定时器：节流刷新位置，支持斜向
            Timer {
                id: moveTimer
                interval: 16   // ~60 FPS
                repeat: true
                onTriggered: {
                    var speed = 4
                    var newX = player.x
                    var newY = player.y

                    if (field.pressedKeys.left)  newX -= speed
                    if (field.pressedKeys.right) newX += speed
                    if (field.pressedKeys.up)    newY -= speed
                    if (field.pressedKeys.down)  newY += speed

                    // 边界检测
                    newX = Math.max(0, Math.min(field.width - player.width, newX))
                    newY = Math.max(0, Math.min(field.height - player.height, newY))

                    player.x = newX
                    player.y = newY
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: field.forceActiveFocus()
            }
        }

        // 提示
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 16

            Text {
                text: "WASD / 方向键：移动"
                font.pointSize: 11
                color: "#666"
            }
            Text {
                text: "R：回到中心"
                font.pointSize: 11
                color: "#666"
            }
        }
    }
}
