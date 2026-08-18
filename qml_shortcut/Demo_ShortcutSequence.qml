import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "组合键序列"
            description: "演示多键序列（如 Ctrl+Shift+S）与多 Shortcut 并存的处理方式"
        }

        // 多键序列快捷键
        Shortcut {
            sequence: "Ctrl+Shift+S"
            onActivated: {
                triggerLabel.text = "Ctrl+Shift+S - 另存为"
                triggerLabel.color = "#1296FF"
                flashAnim.start()
            }
        }

        Shortcut {
            sequence: "Ctrl+Shift+A"
            onActivated: {
                triggerLabel.text = "Ctrl+Shift+A - 全选"
                triggerLabel.color = "#21be2b"
                flashAnim.start()
            }
        }

        Shortcut {
            sequence: "Ctrl+K, Ctrl+C"
            onActivated: {
                triggerLabel.text = "Ctrl+K, Ctrl+C - VSCode 风格注释"
                triggerLabel.color = "#FF9800"
                flashAnim.start()
            }
        }

        // 提示卡片
        Column {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            Repeater {
                model: [
                    { key: "Ctrl+Shift+S", label: "另存为", color: "#1296FF" },
                    { key: "Ctrl+Shift+A", label: "全选", color: "#21be2b" },
                    { key: "Ctrl+K, Ctrl+C", label: "VSCode 注释", color: "#FF9800" }
                ]
                delegate: Rectangle {
                    width: 320
                    height: 44
                    radius: 6

                    Row {
                        anchors.left: parent.left
                        spacing: 12

                        Rectangle {
                            width: 140
                            height: 26
                            radius: 4
                            color: modelData.color
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                anchors.centerIn: parent
                                text: modelData.key
                                color: "white"
                                font.pointSize: 10
                                font.bold: true
                            }
                        }

                        Text {
                            text: modelData.label
                            font.pointSize: 12
                            color: Qt.darker(modelData.color, 1.3)
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }

        // 触发显示区
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 360
            height: 60
            radius: 10
            color: "#EAF4FF"
            border.color: "#1296FF"
            border.width: 1

            Text {
                id: triggerLabel
                anchors.centerIn: parent
                text: "按下组合键试试"
                font.pointSize: 15
                font.bold: true
                color: "#1296FF"
            }

            SequentialAnimation {
                id: flashAnim
                NumberAnimation { target: triggerLabel; property: "opacity"; to: 0.3; duration: 80 }
                NumberAnimation { target: triggerLabel; property: "opacity"; to: 1.0; duration: 120 }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "提示：Ctrl+K, Ctrl+C 是 VSCode 风格的连续键序列"
            font.pointSize: 12
            color: "#999"
        }

        Item { Layout.fillHeight: true }
    }
}
