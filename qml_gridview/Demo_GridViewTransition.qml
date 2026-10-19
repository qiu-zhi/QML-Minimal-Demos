import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ListModel {
        id: tagModel
        ListElement { tagName: "风景"; tagColor: "#2ecc71" }
        ListElement { tagName: "人像"; tagColor: "#3498db" }
        ListElement { tagName: "街拍"; tagColor: "#e67e22" }
        ListElement { tagName: "美食"; tagColor: "#e74c3c" }
        ListElement { tagName: "夜景"; tagColor: "#9b59b6" }
        ListElement { tagName: "建筑"; tagColor: "#1abc9c" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "增删动画"
            description: "add/remove 控制新旧项自身的进出，displaced 负责被挤动的项滑到新位置。"
        }

        // 操作按钮
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "随机新增"
                font.pointSize: 10
                onClicked: {
                    var colors = ["#16a085", "#2980b9", "#8e44ad", "#c0392b", "#d35400", "#27ae60"]
                    var names = ["星空", "海洋", "森林", "沙漠", "雪山", "草原"]
                    var i = Math.floor(Math.random() * names.length)
                    tagModel.insert(Math.floor(Math.random() * tagModel.count), {
                        "tagName": names[i],
                        "tagColor": colors[i]
                    })
                }
            }

            Button {
                text: "删除首项"
                font.pointSize: 10
                enabled: tagModel.count > 0
                onClicked: tagModel.remove(0)
            }

            Button {
                text: "打乱顺序"
                font.pointSize: 10
                onClicked: {
                    // 未定义 move 过渡：被移动项直接跳到新格，邻居走 displaced 滑过去
                    for (var i = 0; i < 3; i++) {
                        var from = Math.floor(Math.random() * tagModel.count)
                        var to = Math.floor(Math.random() * tagModel.count)
                        tagModel.move(from, to, 1)
                    }
                }
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "共 " + tagModel.count + " 项"
                font.pointSize: 10
                color: "#666"
            }
        }

        // 内容卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            GridView {
                id: grid
                anchors.fill: parent
                anchors.margins: 10
                clip: true

                cellWidth: 90
                cellHeight: 70
                model: tagModel

                // 新增的项从 (100,100) 位置滑入并淡入
                add: Transition {
                    NumberAnimation { properties: "x,y"; from: 100; duration: 300; easing.type: Easing.OutBack }
                    NumberAnimation { property: "opacity"; from: 0; duration: 300 }
                }

                // 删除的项淡出
                remove: Transition {
                    NumberAnimation { property: "opacity"; to: 0; duration: 250 }
                }

                // 被挤动的项滑到新格子
                displaced: Transition {
                    NumberAnimation { properties: "x,y"; duration: 300; easing.type: Easing.OutCubic }
                }

                delegate: Item {
                    id: cell
                    required property int index
                    required property string tagName
                    required property string tagColor

                    // remove 过渡期间本 delegate 仍存活，但 index 已过期，置位后忽略重复点击
                    property bool removing: false

                    width: grid.cellWidth
                    height: grid.cellHeight

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 5
                        radius: 8
                        color: cell.tagColor

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: cell.tagName
                                color: "white"
                                font.pointSize: 12
                                font.bold: true
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "#" + (cell.index + 1)
                                color: "#FFFFFFAA"
                                font.pointSize: 9
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // 点谁删谁，观察 remove 和 displaced 的配合
                                // 动画期间 index 不再更新，先校验范围防止删错项
                                if (cell.removing || cell.index < 0 || cell.index >= tagModel.count)
                                    return
                                cell.removing = true
                                tagModel.remove(cell.index)
                            }
                        }
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            text: "点击任意标签可删除该项"
            font.pointSize: 10
            color: "#999"
        }
    }
}
