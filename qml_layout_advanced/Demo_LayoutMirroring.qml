import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "布局镜像"
            description: "LayoutMirroring 是附加属性，打开后把带锚点的布局整体左右翻转，用来适配从右向左书写的语言。写死的 x 坐标不受影响。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 24

            CheckBox {
                id: mirrorCheck
                text: "enabled（整体镜像）"
                checked: false
            }

            CheckBox {
                id: inheritCheck
                text: "childrenInherit（子项跟随）"
                checked: true
            }

            Item { Layout.fillWidth: true }
        }

        Rectangle {
            id: stage
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FFFFFF"
            border.color: "#e0e0e0"
            radius: 8
            clip: true

            LayoutMirroring.enabled: mirrorCheck.checked
            LayoutMirroring.childrenInherit: inheritCheck.checked

            // 带锚点的 Row：开启镜像后贴到右边，子项顺序也会翻转
            Row {
                id: row
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 16
                anchors.topMargin: 30
                spacing: 8

                Repeater {
                    model: 4
                    Rectangle {
                        width: 52
                        height: 52
                        radius: 6
                        color: "#1296FF"
                        opacity: 0.35 + index * 0.2

                        Text {
                            anchors.centerIn: parent
                            text: index + 1
                            color: "white"
                            font.pointSize: 15
                            font.bold: true
                        }
                    }
                }
            }

            Text {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 16
                anchors.topMargin: 8
                text: "带锚点的 Row（x = " + row.x.toFixed(0) + "）"
                color: "#666"
                font.pointSize: 10
            }

            Text {
                x: 16
                y: stage.height / 2 - 22
                text: "写死 x 的方块，镜像对它无效"
                color: "#E67E22"
                font.pointSize: 10
            }

            Rectangle {
                x: 16
                y: stage.height / 2
                width: 52
                height: 52
                radius: 6
                color: "#E67E22"

                Text {
                    anchors.centerIn: parent
                    text: "x=16"
                    color: "white"
                    font.pointSize: 10
                    font.bold: true
                }
            }
        }
    }
}
