import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    id: root

    // 三个看板列共享的任务数据
    ListModel { id: todoModel }
    ListModel { id: doingModel }
    ListModel { id: doneModel }

    property int moveCount: 0

    Component.onCompleted: {
        todoModel.append({ title: "设计登录页线框图", priority: "高", color: "#FF6B6B" })
        todoModel.append({ title: "编写 API 文档", priority: "中", color: "#FFC107" })
        todoModel.append({ title: "整理测试用例", priority: "低", color: "#4CAF50" })
        doingModel.append({ title: "实现拖拽排序组件", priority: "高", color: "#FF6B6B" })
        doneModel.append({ title: "搭建项目骨架", priority: "中", color: "#FFC107" })
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "看板跨容器拖拽"
            description: "三个 ListModel 表示不同状态列，拖动卡片到任一列即在模型间迁移数据，DropArea 完成跨容器接收"
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            // ====== 待办列 ======
            Rectangle {
                id: todoCol
                width: 200; height: 320
                radius: 10
                color: todoDrop.containsDrag ? "#EAF4FF" : "#FAFAFA"
                border.color: todoDrop.containsDrag ? "#1296FF" : "#ddd"
                border.width: todoDrop.containsDrag ? 2 : 1

                Behavior on color { ColorAnimation { duration: 120 } }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 6

                    Text {
                        text: "待办 (" + todoModel.count + ")"
                        font.pointSize: 12; font.bold: true; color: "#333"
                    }

                    ListView {
                        id: todoList
                        Layout.fillWidth: true; Layout.fillHeight: true
                        clip: true
                        spacing: 6
                        model: todoModel
                        displaced: Transition {
                            NumberAnimation { properties: "x,y"; duration: 200; easing.type: Easing.OutQuad }
                        }

                        delegate: cardDelegate

                        DropArea {
                            id: todoDrop
                            anchors.fill: parent
                            onEntered: (drag) => drag.accepted = drag.formats.indexOf("text/source") >= 0
                            onDropped: (drop) => root.moveCard(drop, todoModel, todoList)
                        }
                    }
                }
            }

            // ====== 进行中列 ======
            Rectangle {
                id: doingCol
                width: 200; height: 320
                radius: 10
                color: doingDrop.containsDrag ? "#FFF4E5" : "#FAFAFA"
                border.color: doingDrop.containsDrag ? "#FF9800" : "#ddd"
                border.width: doingDrop.containsDrag ? 2 : 1

                Behavior on color { ColorAnimation { duration: 120 } }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 6

                    Text {
                        text: "进行中 (" + doingModel.count + ")"
                        font.pointSize: 12; font.bold: true; color: "#333"
                    }

                    ListView {
                        id: doingList
                        Layout.fillWidth: true; Layout.fillHeight: true
                        clip: true
                        spacing: 6
                        model: doingModel
                        displaced: Transition {
                            NumberAnimation { properties: "x,y"; duration: 200; easing.type: Easing.OutQuad }
                        }

                        delegate: cardDelegate

                        DropArea {
                            id: doingDrop
                            anchors.fill: parent
                            onEntered: (drag) => drag.accepted = drag.formats.indexOf("text/source") >= 0
                            onDropped: (drop) => root.moveCard(drop, doingModel, doingList)
                        }
                    }
                }
            }

            // ====== 已完成列 ======
            Rectangle {
                id: doneCol
                width: 200; height: 320
                radius: 10
                color: doneDrop.containsDrag ? "#E8F5E9" : "#FAFAFA"
                border.color: doneDrop.containsDrag ? "#4CAF50" : "#ddd"
                border.width: doneDrop.containsDrag ? 2 : 1

                Behavior on color { ColorAnimation { duration: 120 } }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 6

                    Text {
                        text: "已完成 (" + doneModel.count + ")"
                        font.pointSize: 12; font.bold: true; color: "#333"
                    }

                    ListView {
                        id: doneList
                        Layout.fillWidth: true; Layout.fillHeight: true
                        clip: true
                        spacing: 6
                        model: doneModel
                        displaced: Transition {
                            NumberAnimation { properties: "x,y"; duration: 200; easing.type: Easing.OutQuad }
                        }

                        delegate: cardDelegate

                        DropArea {
                            id: doneDrop
                            anchors.fill: parent
                            onEntered: (drag) => drag.accepted = drag.formats.indexOf("text/source") >= 0
                            onDropped: (drop) => root.moveCard(drop, doneModel, doneList)
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 640
            text: "拖拽任一卡片到其他列，卡片数据会在 ListModel 之间迁移"
            font.pointSize: 11
            color: "#666"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "累计跨列移动: " + root.moveCount
            font.pointSize: 12
            color: "#1296FF"
            font.bold: true
        }

        Item { Layout.fillHeight: true }
    }

    // 卡片样式：定义在根作用域供三列 ListView 共用
    Component {
        id: cardDelegate

        Rectangle {
            id: card
            width: ListView.view ? ListView.view.width - 4 : 180
            height: 64
            radius: 8
            color: model.color
            opacity: cardDrag.drag.active ? 0.4 : 1.0

            Behavior on opacity { NumberAnimation { duration: 120 } }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 2

                Text {
                    Layout.fillWidth: true
                    text: model.title
                    color: "white"
                    font.pointSize: 11
                    font.bold: true
                    wrapMode: Text.Wrap
                }
                Text {
                    text: "优先级: " + model.priority
                    color: Qt.rgba(1, 1, 1, 0.85)
                    font.pointSize: 9
                }
            }

            // 标记自己是源 + 记录源模型信息
            Drag.active: cardDrag.drag.active
            Drag.dragType: Drag.Automatic
            Drag.supportedActions: Qt.CopyAction
            Drag.mimeData: {
                "text/source": "card",
                "text/title": model.title,
                "text/priority": model.priority,
                "text/color": model.color,
                "text/index": index.toString()
            }

            MouseArea {
                id: cardDrag
                anchors.fill: parent
                drag.target: parent
                cursorShape: Qt.OpenHandCursor
            }
        }
    }

    // 跨列迁移逻辑：从 drop 数据中取出原卡片，从其源 ListView 的 model 中移除，再追加到目标 model
    function moveCard(drop, targetModel, targetList) {
        if (drop.formats.indexOf("text/source") < 0) {
            drop.accepted = false
            return
        }
        var title = drop.getDataAsString("text/title")
        var priority = drop.getDataAsString("text/priority")
        var color = drop.getDataAsString("text/color")

        // 在三个模型中查找并移除原始卡片
        var removed = false
        if (!removed) removed = removeFromModel(todoModel, title)
        if (!removed) removed = removeFromModel(doingModel, title)
        if (!removed) removed = removeFromModel(doneModel, title)

        // 追加到目标列
        targetModel.append({ title: title, priority: priority, color: color })

        statusText.text = "已将「" + title + "」移动到新列"
        root.moveCount++
        drop.accepted = true
    }

    function removeFromModel(model, title) {
        for (var i = 0; i < model.count; i++) {
            if (model.get(i).title === title) {
                model.remove(i, 1)
                return true
            }
        }
        return false
    }
}
