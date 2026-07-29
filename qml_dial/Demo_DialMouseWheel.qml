import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Dial 鼠标滚轮"
            description: "使用 MouseArea 包裹 Dial 处理滚轮事件，支持 Ctrl/Shift 调整步长"
        }

        Dial {
            id: control
            Layout.alignment: Qt.AlignHCenter
            width: 140
            height: 140
            from: 0
            to: 100
            value: 50
            stepSize: 1  // 基础步长

            // 包裹Dial的MouseArea处理滚轮事件
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton  // 不拦截鼠标点击，仅处理滚轮
                hoverEnabled: true
                onWheel: function(wheel) {
                    // 根据Ctrl/Shift修饰键动态调整步长
                    var step = control.stepSize
                    if (wheel.modifiers & Qt.ControlModifier) {
                        step = 1  // 精细调节
                    } else if (wheel.modifiers & Qt.ShiftModifier) {
                        step = 5   // 快速调节
                    }

                    // 根据滚轮方向增减值
                    control.value += wheel.angleDelta.y > 0 ? step : -step
                    wheel.accepted = true  // 阻止事件继续传递
                }
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
