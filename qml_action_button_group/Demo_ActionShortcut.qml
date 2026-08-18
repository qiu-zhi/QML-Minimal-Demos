import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Action - 快捷键触发"
            description: "为 Action 设置 shortcut 后，即使焦点不在按钮上，按下快捷键也能触发；菜单项右侧自动显示快捷键"
        }

        // 一组带快捷键的 Action，逻辑统一维护
        Action { id: newAction;   text: "新建"; shortcut: "Ctrl+N"; onTriggered: show("新建") }
        Action { id: saveAction;  text: "保存"; shortcut: "Ctrl+S"; onTriggered: show("保存") }
        Action { id: printAction; text: "打印"; shortcut: "Ctrl+P"; onTriggered: show("打印") }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12

            Button { action: newAction; Layout.preferredHeight: 36 }
            Button { action: saveAction; Layout.preferredHeight: 36 }
            Button { action: printAction; Layout.preferredHeight: 36 }

            ToolButton {
                text: "文件菜单"
                Layout.preferredHeight: 36
                onClicked: fileMenu.open()
                Menu {
                    id: fileMenu
                    MenuItem { action: newAction }
                    MenuItem { action: saveAction }
                    MenuItem { action: printAction }
                }
            }
        }

        Text {
            id: tip
            Layout.fillWidth: true
            color: "#1296FF"
            font.pointSize: 11
            text: ""
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 11
            text: "提示：请直接按 Ctrl+N / Ctrl+S / Ctrl+P"
        }

        Item { Layout.fillHeight: true }
    }

    function show(name) {
        tip.text = "已触发：" + name
    }
}
