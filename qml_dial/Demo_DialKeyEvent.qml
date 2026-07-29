import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Dial 键盘事件"
            description: "通过 Keys.onPressed 处理方向键、Home、End 等按键，Shift 加速"
        }

        Dial {
            id: control
            Layout.alignment: Qt.AlignHCenter
            width: 140
            height: 140
            from: 0
            to: 100
            stepSize: 1
            value: 50

            // 对焦到此控件上
            focusPolicy: Qt.StrongFocus
            activeFocusOnTab: true

            Component.onCompleted: control.forceActiveFocus()

            // 键盘事件处理（此函数下的功能在内部原本就存在，这里还能自定义处理）
            Keys.onPressed: function(event) {
                console.log("key: ", event.key)
                const step = event.modifiers & Qt.ShiftModifier ? 10 : 1
                switch(event.key) {
                case Qt.Key_Up:
                case Qt.Key_Right:
                    control.value = Math.min(control.value + step, control.to)
                    break
                case Qt.Key_Down:
                case Qt.Key_Left:
                    control.value = Math.max(control.value - step, control.from)
                    break
                case Qt.Key_Home:
                    control.value = control.from
                    break
                case Qt.Key_End:
                    control.value = control.to
                    break
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
