import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "音频均衡器"
            description: "使用 5 个 Dial 组成音频均衡器，模拟频段增益调节"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 240
            color: "#1a1a1a"
            radius: 6

            Grid {
                anchors.centerIn: parent
                columns: 5
                spacing: 10

                // 使用对象数组存储数值
                property var bandNames: ["60Hz", "150Hz", "400Hz", "1kHz", "2.4kHz"]
                property var bandValues: ([-12, -12, -12, -12, -12].map(v => ({ value: v })))

                Repeater {
                    model: 5

                    Column {
                        id: bandColumn
                        spacing: 8
                        width: 90

                        Dial {
                            id: dial
                            width: 80
                            height: 80
                            from: -12
                            to: 12
                            value: 0
                            snapMode: Dial.SnapAlways
                            stepSize: 1.0

                            readonly property real innerRadius: bg.width/2
                                                              - bg.border.width
                                                              - handleItem.width/2

                            background: Rectangle {
                                id: bg  // 给背景命名
                                radius: width / 2
                                color: "#333333"
                                border.color: "#555555"
                                border.width: 2
                            }

                            handle: Rectangle {
                                id: handleItem
                                width: 16
                                height: 16
                                radius: width / 2
                                antialiasing: true
                                color: "lime"

                                transform: [
                                    Translate {
                                        x: bg.width/2 - handleItem.width/2
                                        y: bg.height/2 - handleItem.height/2 - dial.innerRadius
                                    },
                                    Rotation {
                                        angle: dial.angle
                                        origin.x: bg.width/2
                                        origin.y: bg.height/2
                                    }
                                ]
                            }

                            // 强制触发数组更新
                            onValueChanged: {
                                let temp = [...bandColumn.parent.bandValues]
                                temp[index].value = Number(value.toFixed(1))
                                bandColumn.parent.bandValues = temp
                            }
                        }

                        Text {
                            text: bandColumn.parent.bandNames[index]
                            color: "white"
                            font.pixelSize: 14
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        // 直接绑定dial.value
                        Text {
                            text: Number(dial.value.toFixed(1)) + " dB"
                            color: "lime"
                            font.pixelSize: 14
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
