import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "DropArea 放置区"
            description: "拖拽色块并携带 mimeData，DropArea 通过 containsDrag、onDropped 接收并处理拖入的元素"
        }

        // 顶部：可拖拽的源色块
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Repeater {
                id: sourceRepeater
                model: ListModel {
                    id: sourceModel
                    ListElement { color: "#FF6B6B"; label: "红"; dropped: false }
                    ListElement { color: "#4CAF50"; label: "绿"; dropped: false }
                    ListElement { color: "#FFC107"; label: "黄"; dropped: false }
                    ListElement { color: "#9C27B0"; label: "紫"; dropped: false }
                }

                Rectangle {
                    // 色块放入放置区后隐藏
                    visible: !model.dropped
                    width: 70
                    height: 70
                    radius: 10
                    color: model.color
                    opacity: dragHandler.active ? 0.4 : 1.0

                    Text {
                        anchors.centerIn: parent
                        text: model.label
                        color: "white"
                        font.pointSize: 16
                        font.bold: true
                    }

                    // 用 DragHandler 驱动 Drag.active（Qt6 推荐，自动处理拖拽阈值）：
                    // 色块始终保持在原位（不物理移动），通过 Drag 会话传递 mimeData 给 DropArea
                    Drag.active: dragHandler.active
                    Drag.dragType: Drag.Automatic
                    Drag.supportedActions: Qt.CopyAction
                    Drag.mimeData: { "text/color": model.color, "text/label": model.label }

                    DragHandler {
                        id: dragHandler
                        target: null
                        acceptedButtons: Qt.LeftButton
                        cursorShape: Qt.OpenHandCursor
                    }
                }
            }
        }

        // 放置区
        Rectangle {
            id: dropZone
            Layout.alignment: Qt.AlignHCenter
            width: 480
            height: 200
            radius: 14
            color: dropArea.containsDrag ? "#EAF4FF" : "#FAFAFA"
            border.color: dropArea.containsDrag ? "#1296FF" : "#CCCCCC"
            border.width: dropArea.containsDrag ? 3 : 1

            Behavior on color { ColorAnimation { duration: 150 } }
            Behavior on border.width { NumberAnimation { duration: 120 } }

            Text {
                anchors.centerIn: parent
                text: dropArea.containsDrag
                      ? "松手以放入"
                      : (dropZone.droppedColor === ""
                         ? "将上方色块拖入此区域"
                         : "已放入：" + dropZone.droppedLabel)
                font.pointSize: 18
                font.bold: true
                color: dropArea.containsDrag ? "#1296FF" : (dropZone.droppedColor || "#999")
            }

            property string droppedColor: ""
            property string droppedLabel: ""
            property int dropCount: 0

            DropArea {
                id: dropArea
                anchors.fill: parent

                onEntered: (drag) => {
                    // 校验是否携带我们关心的 mimeData
                    drag.accepted = drag.formats.indexOf("text/color") >= 0
                }

                onDropped: (drop) => {
                    if (drop.formats.indexOf("text/color") >= 0) {
                        var color = drop.getDataAsString("text/color")
                        // 隐藏对应的源色块
                        for (var i = 0; i < sourceModel.count; i++) {
                            if (sourceModel.get(i).color === color) {
                                sourceModel.setProperty(i, "dropped", true)
                                break
                            }
                        }
                        dropZone.droppedColor = color
                        dropZone.droppedLabel = drop.getDataAsString("text/label")
                        dropZone.dropCount++
                        statusText.text = "已接收 " + dropZone.dropCount + " 次 → " + dropZone.droppedLabel + " (" + color + ")"
                        drop.accepted = true
                    } else {
                        drop.accepted = false
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 480
            text: "拖拽顶部色块到上方区域，观察 containsDrag 状态变化"
            font.pointSize: 11
            color: "#666"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Button {
                text: "清空放置区"
                onClicked: {
                    // 还原所有源色块
                    for (var i = 0; i < sourceModel.count; i++) {
                        sourceModel.setProperty(i, "dropped", false)
                    }
                    dropZone.droppedColor = ""
                    dropZone.droppedLabel = ""
                    statusText.text = "已清空放置区，色块已还原"
                }
            }

            Text {
                text: "累计接收: " + dropZone.dropCount
                font.pointSize: 12
                color: "#1296FF"
                font.bold: true
            }
        }

        Item { Layout.fillHeight: true }
    }
}
