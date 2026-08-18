import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "单键快捷键"
            description: "演示 F1 帮助、Esc 取消、Space 播放/暂停、Delete 删除等单键快捷键的用法"
        }

        // 单键快捷键
        Shortcut {
            sequence: "F1"
            onActivated: {
                statusText.text = "F1 - 打开帮助"
            }
        }

        Shortcut {
            sequence: "Esc"
            onActivated: {
                statusText.text = "Esc - 取消/关闭"
            }
        }

        Shortcut {
            sequence: "Space"
            onActivated: {
                statusText.text = "Space - 暂停/播放"
            }
        }

        Shortcut {
            sequence: "Delete"
            onActivated: {
                statusText.text = "Delete - 删除"
            }
        }

        // 功能键按钮展示
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Repeater {
                model: [
                    { key: "F1", label: "帮助", color: "#1296FF" },
                    { key: "Esc", label: "取消", color: "#e74c3c" },
                    { key: "Space", label: "播放/暂停", color: "#21be2b" },
                    { key: "Del", label: "删除", color: "#FF9800" }
                ]
                delegate: Rectangle {
                    width: 80
                    height: 90
                    radius: 10
                    color: "#FAFAFA"
                    border.color: modelData.color
                    border.width: 2

                    Column {
                        anchors.centerIn: parent
                        spacing: 6

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.key
                            font.pointSize: 16
                            font.bold: true
                            color: modelData.color
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.label
                            font.pointSize: 9
                            color: "#666"
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            text: "按下 F1 / Esc / Space / Delete 试试"
            font.pointSize: 12
            color: "#999"
        }

        Item { Layout.fillHeight: true }
    }
}
