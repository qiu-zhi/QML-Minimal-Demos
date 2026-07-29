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
            title: "自定义样式 —— 滚动列表"
            description: "使用 ListView 作为 contentItem，配合高亮移动动画实现数字滚动切换效果"
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            spacing: 10

            SpinBox {
                id: control
                editable: false
                from: 0
                to: 100

                background: Rectangle {
                    implicitWidth: 140
                    implicitHeight: 40
                    radius: height / 2
                    color: control.enabled ? "#fff" : "#f0f0f0"
                    border.color: control.focus ? "#1296ff" : "#bdbdbd"
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
                    height: parent.height
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
                }

                down.indicator: Rectangle {
                    x: 0
                    height: parent.height
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
                }

                // 核心滚动区域
                contentItem: ListView {
                    id: rollingList
                    clip: true
                    model: control.to - control.from + 1
                    currentIndex: control.value - control.from

                    // 禁止手动拖拽，只通过按钮控制
                    interactive: false

                    // 设置滚动动画速度和曲线
                    highlightMoveDuration: 300
                    highlightMoveVelocity: -1 // 强制使用 duration
                    preferredHighlightBegin: 0
                    preferredHighlightEnd: height
                    highlightRangeMode: ListView.ApplyRange

                    delegate: Item {
                        width: rollingList.width
                        height: rollingList.height

                        Text {
                            text: index + control.from
                            anchors.centerIn: parent
                            color: "#333"
                            font.pointSize: 11
                        }
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：仅可通过按钮控制滚动，禁用手动拖拽，高亮动画时长 300ms"
        }

        Item { Layout.fillHeight: true }
    }
}
