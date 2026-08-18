import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础快捷键"
            description: "使用 Shortcut 组件注册 Ctrl+S / Ctrl+C / Ctrl+V 等基础快捷键，触发 activated 信号"
        }

        // 快捷键注册
        Shortcut {
            sequence: "Ctrl+S"
            onActivated: {
                logModel.append({ text: "Ctrl+S - 保存", time: Qt.formatTime(new Date(), "hh:mm:ss") })
                statusText.text = "已执行: 保存"
            }
        }

        Shortcut {
            sequence: "Ctrl+C"
            onActivated: {
                logModel.append({ text: "Ctrl+C - 复制", time: Qt.formatTime(new Date(), "hh:mm:ss") })
                statusText.text = "已执行: 复制"
            }
        }

        Shortcut {
            sequence: "Ctrl+V"
            onActivated: {
                logModel.append({ text: "Ctrl+V - 粘贴", time: Qt.formatTime(new Date(), "hh:mm:ss") })
                statusText.text = "已执行: 粘贴"
            }
        }

        // 快捷键提示卡片
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12

            Repeater {
                model: [
                    { key: "Ctrl+S", label: "保存", color: "#1296FF" },
                    { key: "Ctrl+C", label: "复制", color: "#21be2b" },
                    { key: "Ctrl+V", label: "粘贴", color: "#FF9800" }
                ]
                delegate: Rectangle {
                    width: 100
                    height: 70
                    radius: 8
                    color: Qt.lighter(modelData.color, 1.1)
                    border.color: Qt.darker(modelData.color, 1.05)
                    border.width: 1

                    Column {
                        anchors.centerIn: parent
                        spacing: 4

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.key
                            font.pointSize: 13
                            font.bold: true
                            color: Qt.darker(modelData.color, 1.6)
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.label
                            font.pointSize: 10
                            color: Qt.darker(modelData.color, 1.3)
                        }
                    }
                }
            }
        }

        // 操作日志
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 4

                Text {
                    text: "操作日志"
                    font.pointSize: 11
                    font.bold: true
                    color: "#666"
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: ListModel { id: logModel }
                    delegate: Text {
                        text: "[" + model.time + "] " + model.text
                        font.pointSize: 11
                        color: "#333"
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            text: "按下 Ctrl+S / Ctrl+C / Ctrl+V 试试"
            font.pointSize: 12
            color: "#999"
        }

        Item { height: 4 }
    }
}
