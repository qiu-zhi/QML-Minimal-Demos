import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "RangeSlider 样式"
            description: "自定义 RangeSlider 的背景和两个手柄的样式"
        }

        RangeSlider {
            id: customSlider
            from: 0
            to: 100
            first.value: 20
            second.value: 80
            stepSize: 1
            Layout.fillWidth: true

            // 自定义背景样式
            background: Rectangle {
                x: customSlider.leftPadding
                y: customSlider.topPadding + customSlider.availableHeight / 2 - height / 2
                width: customSlider.availableWidth
                height: 4
                radius: 2
                color: "#e0e0e0"

                // 选中区域的样式
                Rectangle {
                    x: customSlider.first.visualPosition * parent.width
                    width: customSlider.second.visualPosition * parent.width - x
                    height: parent.height
                    color: "#4CAF50"
                    radius: 2
                }
            }

            // 第一个滑块的样式
            first.handle: Rectangle {
                x: customSlider.leftPadding + customSlider.first.visualPosition
                   * (customSlider.availableWidth - width)
                y: customSlider.topPadding + customSlider.availableHeight / 2 - height / 2
                width: 20
                height: 20
                radius: 10
                color: customSlider.first.pressed ? "#e0e0e0" : "#ffffff"
                border.color: "#bdbebf"
                border.width: 1
            }

            // 第二个滑块的样式
            second.handle: Rectangle {
                x: customSlider.leftPadding + customSlider.second.visualPosition
                   * (customSlider.availableWidth - width)
                y: customSlider.topPadding + customSlider.availableHeight / 2 - height / 2
                width: 20
                height: 20
                radius: 10
                color: customSlider.second.pressed ? "#e0e0e0" : "#ffffff"
                border.color: "#bdbebf"
                border.width: 1
            }
        }

        Text {
            text: "当前范围: " + Math.round(customSlider.first.value) + " - " + Math.round(customSlider.second.value)
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
