import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 计数属性定义在文件根对象上（QML 作用域规则：子对象只能通过
    // 裸名称访问文件根对象的属性，中间层对象必须借助 id 访问）。
    property int editCount: 0
    property int previewCount: 0

    // 计数卡片查询函数（供 Repeater 委托调用，实时刷新）
    function countOf(i) {
        if (i === 0) return editCount
        return previewCount
    }
    function countColor(i) {
        if (i === 0) return "#1296FF"
        return "#FF9800"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "上下文作用域"
            description: "同一个 Ctrl+D 快捷键通过 enabled 绑定按编辑/预览模式切换，执行不同的操作"
        }

        // 仅编辑模式快捷键：enabled 绑定条件控制
        Shortcut {
            sequence: "Ctrl+D"
            enabled: editModeSwitch.checked
            onActivated: {
                editCount++
                statusText.text = "Ctrl+D - 编辑模式快捷键 (enabled 绑定)\n触发次数: " + editCount
            }
        }

        // 仅预览模式快捷键
        Shortcut {
            sequence: "Ctrl+D"
            enabled: !editModeSwitch.checked
            onActivated: {
                previewCount++
                statusText.text = "Ctrl+D - 预览模式快捷键 (enabled 绑定)\n触发次数: " + previewCount
            }
        }

        // 模式切换开关
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Switch {
                id: editModeSwitch
                text: checked ? "编辑模式" : "预览模式"
                checked: true
            }
        }

        // 计数统计
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 16

            Repeater {
                // 模型只存放静态数据；计数通过根对象的 countOf()/countColor() 实时求值
                model: [
                    { label: "编辑 Ctrl+D" },
                    { label: "预览 Ctrl+D" }
                ]
                delegate: Rectangle {
                    width: 110
                    height: 56
                    radius: 8
                    color: Qt.lighter(countColor(index), 1.1)
                    border.color: Qt.darker(countColor(index), 1.05)
                    border.width: 1

                    Column {
                        anchors.centerIn: parent
                        spacing: 2

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.label
                            font.pointSize: 9
                            color: Qt.darker(countColor(index), 1.3)
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: countOf(index) + " 次"
                            font.pointSize: 16
                            font.bold: true
                            color: Qt.darker(countColor(index), 1.6)
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 460
            text: "Ctrl+D 根据模式切换\n切换模式后同样的 Ctrl+D 执行不同操作"
            font.pointSize: 12
            color: "#999"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        Item { Layout.fillHeight: true }
    }
}
