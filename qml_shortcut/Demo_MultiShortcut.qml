import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 批量创建快捷键。
    // 注意：
    // 1. Repeater 的 delegate 根对象必须是 Item，Shortcut 需要包一层
    //    Item 才能正确关联窗口并注册快捷键（直接以 Shortcut 为根会被拒绝）。
    // 2. Repeater 是 Item 类型，且 Qt 6 会把 delegate 重挂到 Repeater 的
    //    父对象上。因此 Repeater 必须放在 ColumnLayout 之外（挂在根对象上），
    //    否则 8 个不可见的 delegate 会占据布局槽位，把列表压扁。
    Repeater {
        model: shortcutModel
        delegate: Item {
            Shortcut {
                sequence: model.key
                enabled: model.enabled
                onActivated: {
                    // 先计算新计数再写回模型，避免 model.count 读到更新后的值导致差一
                    var newCount = model.count + 1
                    shortcutModel.setProperty(index, "count", newCount)
                    statusText.text = "触发: " + model.key + " - " + model.label +
                                      " (共 " + newCount + " 次)"
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "多快捷键管理"
            description: "使用 Repeater + ListModel 批量管理快捷键，支持动态启用/禁用"
        }

        // 快捷键配置模型
        ListModel {
            id: shortcutModel
            ListElement { label: "新建文件";   key: "Ctrl+N"; enabled: true; count: 0 }
            ListElement { label: "打开文件";   key: "Ctrl+O"; enabled: true; count: 0 }
            ListElement { label: "保存";       key: "Ctrl+S"; enabled: true; count: 0 }
            ListElement { label: "另存为";     key: "Ctrl+Shift+S"; enabled: true; count: 0 }
            ListElement { label: "撤销";       key: "Ctrl+Z"; enabled: true; count: 0 }
            ListElement { label: "重做";       key: "Ctrl+Y"; enabled: false; count: 0 }
            ListElement { label: "查找";       key: "Ctrl+F"; enabled: true; count: 0 }
            ListElement { label: "替换";       key: "Ctrl+H"; enabled: false; count: 0 }
        }

        // 批量创建快捷键（Repeater 见根对象，此处不参与布局）

        // 全部启用/禁用开关
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 30
            spacing: 20

            Switch {
                text: "全部启用"
                checked: true
                onCheckedChanged: {
                    for (var i = 0; i < shortcutModel.count; i++)
                        shortcutModel.setProperty(i, "enabled", checked)
                }
            }

            Button {
                text: "重置计数"
                onClicked: {
                    for (var i = 0; i < shortcutModel.count; i++)
                        shortcutModel.setProperty(i, "count", 0)
                    statusText.text = "已重置所有计数"
                }
            }
        }

        // 快捷键列表
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            ListView {
                anchors.fill: parent
                anchors.margins: 8
                clip: true
                model: shortcutModel
                spacing: 4

                delegate: Rectangle {
                    width: parent.width
                    height: 40
                    radius: 6
                    color: model.enabled ? "#FFFFFF" : "#F0F0F0"
                    border.color: model.enabled ? "#1296FF" : "#ccc"
                    border.width: model.count > 0 ? 2 : 1
                    opacity: model.enabled ? 1.0 : 0.5

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 8

                        // 快捷键标签
                        Rectangle {
                            width: 90
                            height: 22
                            radius: 4
                            color: model.enabled ? "#1296FF" : "#999"

                            Text {
                                anchors.centerIn: parent
                                text: model.key
                                color: "white"
                                font.pointSize: 9
                                font.bold: true
                            }
                        }

                        Text {
                            text: model.label
                            font.pointSize: 11
                            color: model.enabled ? "#333" : "#999"
                            Layout.fillWidth: true
                        }

                        // 触发计数
                        Text {
                            text: model.count > 0 ? model.count + "x" : "—"
                            font.pointSize: 10
                            color: model.count > 0 ? "#1296FF" : "#ccc"
                            font.bold: model.count > 0
                            Layout.preferredWidth: 40
                            horizontalAlignment: Text.AlignRight
                        }

                        // 单独启用/禁用
                        Switch {
                            checked: model.enabled
                            Layout.preferredWidth: 50
                            onCheckedChanged: shortcutModel.setProperty(index, "enabled", checked)
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            text: "按下快捷键试试，可单独或全部启用/禁用"
            font.pointSize: 12
            color: "#999"
        }

        Item { height: 4 }
    }
}
