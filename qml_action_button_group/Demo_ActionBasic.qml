import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 计数：Action 被触发次数（Button / ToolButton / MenuItem 共享同一个 Action）
    property int triggerCount: 0

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Action - 共享复用"
            description: "一个 Action 可被多个控件（Button / ToolButton / MenuItem）共享：文本、图标、启用状态、触发逻辑均统一维护"
        }

        // 唯一的 Action 定义：所有控件引用它
        Action {
            id: saveAction
            text: "保存"
            icon.name: "document-save"
            shortcut: "Ctrl+S"
            onTriggered: {
                triggerCount++
                textResult.text = "Action 触发 " + triggerCount + " 次（来源不限）"
            }
        }

        // 三个不同控件共享同一个 Action
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12

            Button {
                action: saveAction
                Layout.preferredHeight: 40
            }

            ToolButton {
                action: saveAction
                Layout.preferredHeight: 40
            }

            ToolButton {
                text: "打开菜单"
                Layout.preferredHeight: 40
                onClicked: sharedMenu.open()

                Menu {
                    id: sharedMenu
                    MenuItem { action: saveAction }   // 菜单项同样复用 Action
                    MenuSeparator {}
                    MenuItem { text: "占位项（无 Action）"; enabled: false }
                }
            }
        }

        // 启用/禁用 Action，所有绑定控件同步变化
        CheckBox {
            id: enableCheck
            Layout.alignment: Qt.AlignHCenter
            text: "Action.enabled = " + (checked ? "true" : "false")
            checked: true
            onCheckedChanged: saveAction.enabled = checked
        }

        Text {
            id: textResult
            Layout.fillWidth: true
            color: "#1296FF"
            font.pointSize: 11
            text: "尚未触发"
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 11
            wrapMode: Text.Wrap
            text: "提示：上方三个控件共用同一 Action，任一控件点击或按 Ctrl+S 都会触发同一逻辑"
        }

        Item { Layout.fillHeight: true }
    }
}
