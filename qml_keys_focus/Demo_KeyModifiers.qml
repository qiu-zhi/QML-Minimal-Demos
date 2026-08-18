import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "修饰键检测"
            description: "通过 event.modifiers 检测 Ctrl/Shift/Alt/Meta 修饰键组合，并实时显示按键字符与完整修饰组合"
        }

        // 可获取焦点的输入区
        Rectangle {
            id: keyArea
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            radius: 10
            color: activeFocus ? "#EAF4FF" : "#FAFAFA"
            border.color: activeFocus ? "#1296FF" : "#ccc"
            border.width: activeFocus ? 2 : 1

            MouseArea {
                anchors.fill: parent
                onClicked: keyArea.forceActiveFocus()
            }

            Keys.onPressed: (event) => {
                var mods = []
                if (event.modifiers & Qt.ControlModifier) mods.push("Ctrl")
                if (event.modifiers & Qt.ShiftModifier)   mods.push("Shift")
                if (event.modifiers & Qt.AltModifier)     mods.push("Alt")
                if (event.modifiers & Qt.MetaModifier)    mods.push("Meta")
                if (event.modifiers & Qt.KeypadModifier)  mods.push("Keypad")

                // event.text 在按住 Ctrl/Alt 等修饰键时可能为空或不可打印，改用 event.key 推导
                var ch = event.text
                if (ch.length === 0 || ch.charCodeAt(0) < 0x20) {
                    ch = String.fromCharCode(event.key)
                }
                lastKeyText.text = "'" + ch + "'"
                lastModText.text = mods.length > 0 ? mods.join(" + ") : "（无）"
                lastFullText.text = (mods.length > 0 ? mods.join("+") + "+" : "") + lastKeyText.text
            }

            Column {
                anchors.centerIn: parent
                spacing: 4

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: keyArea.activeFocus ? "请按下任意组合键" : "点击获取焦点"
                    font.pointSize: 14
                    color: keyArea.activeFocus ? "#1296FF" : "#999"
                    font.bold: true
                }
            }
        }

        // 最近一次按键
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 130
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1

            GridLayout {
                anchors.fill: parent
                anchors.margins: 14
                columns: 2
                columnSpacing: 20
                rowSpacing: 8

                Text { text: "按键 Key："; font.pointSize: 11; color: "#666"; font.bold: true }
                Text { id: lastKeyText; text: "—"; font.pointSize: 12; color: "#333"; Layout.fillWidth: true }

                Text { text: "修饰键 Modifiers："; font.pointSize: 11; color: "#666"; font.bold: true }
                Text { id: lastModText; text: "—"; font.pointSize: 12; color: "#1296FF"; Layout.fillWidth: true }

                Text { text: "完整序列："; font.pointSize: 11; color: "#666"; font.bold: true }
                Text { id: lastFullText; text: "—"; font.pointSize: 12; color: "#FF9800"; Layout.fillWidth: true; font.bold: true }
            }
        }

        Text {
            text: "提示：按住 Ctrl/Shift/Alt 之一再按字母键，可以观察修饰键组合效果"
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
