import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "刻度标记"
            description: "带刻度标记的 Slider，使用 Repeater 生成刻度"
        }

        Column {
            Layout.fillWidth: true
            spacing: 0
            height: 40

            Slider {
                id: slider
                width: parent.width
                from: 0
                to: 100
                value: 20
                stepSize: 20
                snapMode: Slider.SnapAlways
            }

            Item {
                width: parent.width
                height: 30

                Repeater {
                    model: 6  // 0到100，每20一个刻度，共6个数字

                    Column {
                        x: slider.leftPadding + index * ((slider.availableWidth) / 5) - width/2
                        spacing: 2

                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 2
                            height: 8
                            color: "#888"
                        }

                        Text {
                            text: (index * 20).toString()
                            color: "#888"
                            font.pointSize: 10
                        }
                    }
                }
            }
        }

        Text {
            text: "当前值: " + slider.value
            font.pointSize: 11
        }

        Item { Layout.fillHeight: true }
    }
}
