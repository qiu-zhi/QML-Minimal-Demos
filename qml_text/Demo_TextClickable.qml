import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 可点击文本"
        }

        Text {
            text: "演示交互式文本：点击变色、按下缩放、按钮样式、边框按钮"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
            width: parent.width - 40
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            // 基础点击效果
            Text {
                id: clickText1
                text: "点击我切换颜色"
                font.pointSize: 13
                color: "#1976D2"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        clickText1.color = clickText1.color === "#1976D2" ? "#E91E63" : "#1976D2"
                    }
                }
            }

            // 带按下效果
            Text {
                id: clickText2
                text: "按下缩放效果"
                font.pointSize: 13
                color: "#333"

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        clickText2.scale = 0.9
                        clickText2.color = "#E91E63"
                    }
                    onReleased: {
                        clickText2.scale = 1.0
                        clickText2.color = "#333"
                    }
                }

                Behavior on scale {
                    NumberAnimation { duration: 100 }
                }
            }

            // 按钮样式文本
            Rectangle {
                width: 120
                height: 36
                radius: 4
                color: buttonArea.pressed ? "#1565C0" : "#1976D2"

                Text {
                    anchors.centerIn: parent
                    text: "按钮样式"
                    color: "white"
                    font.pointSize: 12
                }

                MouseArea {
                    id: buttonArea
                    anchors.fill: parent
                }

                Behavior on color {
                    ColorAnimation { duration: 100 }
                }
            }

            // 带边框的点击文本
            Rectangle {
                width: 120
                height: 32
                radius: 16
                border.color: borderArea.pressed ? "#E91E63" : "#1976D2"
                border.width: 2
                color: borderArea.pressed ? "#fce4ec" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "边框按钮"
                    color: borderArea.pressed ? "#E91E63" : "#1976D2"
                    font.pointSize: 12
                }

                MouseArea {
                    id: borderArea
                    anchors.fill: parent
                }

                Behavior on color {
                    ColorAnimation { duration: 100 }
                }
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "实现: MouseArea + Behavior动画"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
