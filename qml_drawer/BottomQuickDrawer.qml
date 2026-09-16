import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 底部抽屉：常用功能宫格（edge: Qt.BottomEdge），点击图标即收起
Drawer {
    id: root
    // 显式挂到窗口 overlay，抽屉的滑动边界就是窗口边缘
    parent: Overlay.overlay
    width: Overlay.overlay.width
    height: 200
    edge: Qt.BottomEdge
    modal: true

    background: Rectangle {
        color: "#e6e6e6"
        border.color: "#ccc"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "常用功能"
            color: "#333"
            font.pointSize: 12
            font.bold: true
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20

            CustomModel { id: quickModel }

            Repeater {
                model: quickModel

                Rectangle {
                    id: quickItem
                    required property string cmIcon
                    required property string cmText
                    required property string cmColor

                    Layout.preferredWidth: 64
                    Layout.preferredHeight: 64
                    color: "#e6e6e6"

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.close()
                    }

                    ColumnLayout {
                        anchors.fill: parent

                        Rectangle {
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 40
                            radius: 20
                            color: quickItem.cmColor
                            Layout.alignment: Qt.AlignHCenter

                            Image {
                                source: quickItem.cmIcon
                                sourceSize.width: 24
                                sourceSize.height: 24
                                anchors.centerIn: parent
                            }
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: quickItem.cmText
                            color: "#6a6a6a"
                            font.bold: true
                            font.pointSize: 11
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
