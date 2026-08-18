import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "按键事件"
            description: "使用 Keys 附加属性处理 onPressed / onReleased，通过 event.key 判断按键并映射为可读名称，在下方灰色文本中实时展示按键数据"
        }

        // 可获取焦点的输入区
        Rectangle {
            id: keyArea
            Layout.fillWidth: true
            Layout.preferredHeight: 140
            radius: 10
            color: keyArea.activeFocus ? "#EAF4FF" : "#FAFAFA"
            border.color: keyArea.activeFocus ? "#1296FF" : "#ccc"
            border.width: keyArea.activeFocus ? 2 : 1

            // 点击后获取焦点
            MouseArea {
                anchors.fill: parent
                onClicked: keyArea.forceActiveFocus()
            }

            // 接收键盘事件的前提：拥有 activeFocus
            Keys.onPressed: (event) => {
                keyLog.text = "Pressed: key=" + keyToString(event.key)
                // 拦截 Esc 键：清空焦点
                if (event.key === Qt.Key_Escape) {
                    event.accepted = true
                    keyArea.focus = false
                }
            }

            Keys.onReleased: (event) => {
                keyLog.text = "Released: key=" + keyToString(event.key)
            }

            Column {
                anchors.centerIn: parent
                spacing: 4

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: keyArea.activeFocus ? "按键已就绪，请按键" : "点击此处获取焦点"
                    font.pointSize: 14
                    color: keyArea.activeFocus ? "#1296FF" : "#999"
                    font.bold: true
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Esc 清空焦点"
                    font.pointSize: 9
                    color: "#999"
                }
            }
        }

        // 按键日志显示区
        Text {
            id: keyLog
            Layout.fillWidth: true
            Layout.topMargin: 4
            text: ""
            font.pointSize: 11
            color: "#666"
            font.bold: false
            wrapMode: Text.WrapAnywhere
        }

        Item {
            Layout.fillHeight: true
        }

    }

    // 将按键码转换为可读字符串
    function keyToString(k) {
        var map = {
            [Qt.Key_Return]: "Return",
            [Qt.Key_Enter]: "Enter",
            [Qt.Key_Space]: "Space",
            [Qt.Key_Tab]: "Tab",
            [Qt.Key_Backtab]: "Backtab",
            [Qt.Key_Backspace]: "Backspace",
            [Qt.Key_Escape]: "Escape",
            [Qt.Key_Delete]: "Delete",
            [Qt.Key_Insert]: "Insert",
            [Qt.Key_Home]: "Home",
            [Qt.Key_End]: "End",
            [Qt.Key_PageUp]: "PageUp",
            [Qt.Key_PageDown]: "PageDown",
            [Qt.Key_Left]: "Left",
            [Qt.Key_Right]: "Right",
            [Qt.Key_Up]: "Up",
            [Qt.Key_Down]: "Down",
            [Qt.Key_Shift]: "Shift",
            [Qt.Key_Control]: "Control",
            [Qt.Key_Alt]: "Alt",
            [Qt.Key_CapsLock]: "CapsLock"
        }
        return map[k] || ("Key_0x" + k.toString(16).toUpperCase())
    }
}
