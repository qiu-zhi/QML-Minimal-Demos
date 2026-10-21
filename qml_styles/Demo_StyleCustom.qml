import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qml_styles

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16

        TitleSeparator {
            title: "自定义控件外观"
            description: "每个控件都留了可替换的部件——按钮的 background、开关的 indicator、滑块的 handle，换掉就是自己的样子。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            Button {
                id: customButton
                text: "自定义按钮"
                implicitWidth: 130

                background: Rectangle {
                    radius: 6
                    color: customButton.pressed ? "#0B6FBF"
                           : customButton.hovered ? "#2AA5FF" : "#1296FF"
                    border.color: "#0B6FBF"
                }

                contentItem: Text {
                    text: customButton.text
                    color: "white"
                    font.pointSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Switch {
                id: customSwitch
                text: "自定义开关"

                indicator: Rectangle {
                    implicitWidth: 42
                    implicitHeight: 20
                    radius: 10
                    color: customSwitch.checked ? "#1296FF" : "#CCCCCC"

                    Rectangle {
                        width: 16
                        height: 16
                        radius: 8
                        color: "white"
                        y: 2
                        x: customSwitch.checked ? parent.width - width - 2 : 2
                        Behavior on x { NumberAnimation { duration: 120 } }
                    }
                }

                contentItem: Text {
                    text: customSwitch.text
                    color: "#333"
                    font.pointSize: 11
                    leftPadding: customSwitch.indicator.width + 8
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Item { Layout.fillWidth: true }
        }

        Slider {
            id: customSlider
            Layout.fillWidth: true
            value: 0.5

            background: Rectangle {
                x: customSlider.leftPadding
                y: customSlider.topPadding + customSlider.availableHeight / 2 - height / 2
                width: customSlider.availableWidth
                height: 6
                radius: 3
                color: "#E0E0E0"

                Rectangle {
                    width: customSlider.visualPosition * parent.width
                    height: parent.height
                    radius: 3
                    color: "#1296FF"
                }
            }

            handle: Rectangle {
                x: customSlider.leftPadding
                   + customSlider.visualPosition * (customSlider.availableWidth - width)
                y: customSlider.topPadding + customSlider.availableHeight / 2 - height / 2
                width: 18
                height: 18
                radius: 9
                color: customSlider.pressed ? "#0B6FBF" : "#1296FF"
                border.color: "white"
                border.width: 2
            }
        }

        Text {
            Layout.fillWidth: true
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.Wrap
            text: "部件一旦替换，样式自带的交互反馈也不再参与，按压、悬停要在自己的部件里用 pressed、hovered 处理。" +
                  "另外原生样式（Windows 这类）根本不支持自定义——Qt 会在控制台报 " +
                  "\"The current style does not support customization of this control\"。"
        }

        Item { Layout.fillHeight: true }
    }
}
