import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "列表项拖拽排序"
            description: "每个列表项既是拖拽源也是放置区，DropArea.onDropped 中通过 model.move 完成实时重排序"
        }

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 360
            height: 400
            radius: 10
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1
            clip: true

            ListView {
                id: list
                anchors.fill: parent
                anchors.margins: 8
                spacing: 6
                model: ListModel {
                    ListElement { label: "审计用户登录流程"; color: "#FF6B6B" }
                    ListElement { label: "修复登录页样式"; color: "#FF9800" }
                    ListElement { label: "完善个人中心接口"; color: "#FFC107" }
                    ListElement { label: "编写部署脚本"; color: "#4CAF50" }
                    ListElement { label: "升级 Qt 到 6.7"; color: "#1296FF" }
                    ListElement { label: "更新 README 文档"; color: "#9C27B0" }
                }

                displaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 200; easing.type: Easing.OutQuad }
                }

                delegate: Rectangle {
                    id: item
                    width: list.width
                    height: 50
                    radius: 8
                    color: model.color
                    opacity: itemDrag.drag.active ? 0.4 : 1.0

                    Behavior on opacity { NumberAnimation { duration: 120 } }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 8

                        Rectangle {
                            width: 24; height: 24; radius: 12
                            color: Qt.rgba(1, 1, 1, 0.35)
                            Text {
                                anchors.centerIn: parent
                                text: (index + 1)
                                color: "white"
                                font.bold: true
                                font.pointSize: 11
                            }
                        }

                        Text {
                            Layout.fillWidth: true
                            text: model.label
                            color: "white"
                            font.pointSize: 12
                            font.bold: true
                        }

                        Text {
                            text: "⋮⋮"
                            color: Qt.rgba(1, 1, 1, 0.7)
                            font.pointSize: 14
                        }
                    }

                    // 作为拖拽源：用 Drag.active 驱动（无 drag.target，drag.active 恒为 false，
                    // 所以改为绑定 pressed）；源项位置由 ListView 管理，释放时由 DropArea 重排序
                    Drag.active: itemDrag.pressed
                    Drag.dragType: Drag.Automatic
                    Drag.supportedActions: Qt.CopyAction
                    Drag.mimeData: { "text/index": index.toString() }

                    MouseArea {
                        id: itemDrag
                        anchors.fill: parent
                        cursorShape: Qt.SizeAllCursor
                        onReleased: parent.Drag.drop()
                    }

                    DropArea {
                        anchors.fill: parent

                        onEntered: (drag) => {
                            drag.accepted = drag.formats.indexOf("text/index") >= 0
                        }

                        onDropped: (drop) => {
                            var from = parseInt(drop.getDataAsString("text/index"))
                            if (from === index) {
                                drop.accepted = false
                                return
                            }
                            list.model.move(from, index, 1)
                            statusText.text = "已将第 " + (from + 1) + " 项移动到第 " + (index + 1) + " 项的位置"
                            root.moveCount++
                            drop.accepted = true
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 480
            text: "按住列表项左侧拖拽到目标位置完成排序"
            font.pointSize: 11
            color: "#666"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Button {
                text: "恢复初始顺序"
                onClicked: {
                    list.model.move(0, 0, list.model.count) // 触发 displaced 动画
                    list.model.set(0, { label: "审计用户登录流程", color: "#FF6B6B" })
                    list.model.set(1, { label: "修复登录页样式", color: "#FF9800" })
                    list.model.set(2, { label: "完善个人中心接口", color: "#FFC107" })
                    list.model.set(3, { label: "编写部署脚本", color: "#4CAF50" })
                    list.model.set(4, { label: "升级 Qt 到 6.7", color: "#1296FF" })
                    list.model.set(5, { label: "更新 README 文档", color: "#9C27B0" })
                    statusText.text = "已恢复初始顺序"
                }
            }

            Text {
                text: "累计移动: " + root.moveCount
                font.pointSize: 12
                color: "#1296FF"
                font.bold: true
            }
        }

        Item { Layout.fillHeight: true }
    }

    property int moveCount: 0
}
