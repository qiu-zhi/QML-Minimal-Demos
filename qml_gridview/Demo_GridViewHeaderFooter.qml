import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    property int maxCount: 60

    ListModel {
        id: itemModel

        // 用循环一次性填充初始数据，避免逐条罗列 ListElement
        Component.onCompleted: {
            for (var i = 1; i <= 15; i++)
                append({ "num": i })
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "头尾与填充"
            description: "header / footer 会在网格首尾各插入一块固定内容，常用来放分组标题、统计信息和「加载更多」入口；新增项的入场动画由 add 过渡负责。"
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

                model: itemModel
                cellWidth: 92
                cellHeight: 70
                cacheBuffer: 500

                // 头部：分组标题 + 实时计数
                header: Rectangle {
                    width: grid.width
                    height: 44
                    color: "#E8F3FF"
                    radius: 8

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        text: "全部内容"
                        color: "#1296FF"
                        font.pointSize: 12
                        font.bold: true
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        text: "共 " + grid.count + " 项"
                        color: "#1296FF"
                        font.pointSize: 11
                    }
                }

                // 尾部：加载更多入口，加载完切换为提示
                footer: Item {
                    width: grid.width
                    height: 52

                    Button {
                        anchors.centerIn: parent
                        width: 160
                        font.pointSize: 11
                        enabled: grid.count < root.maxCount
                        text: grid.count < root.maxCount ? "加载更多" : "已全部加载"
                        onClicked: {
                            var step = Math.min(9, root.maxCount - grid.count)
                            for (var i = 0; i < step; i++)
                                itemModel.append({ "num": itemModel.count + 1 })
                        }
                    }
                }

                // 新增项的入场动画：首次填充与「加载更多」追加的项都走这里
                add: Transition {
                    NumberAnimation { properties: "x,y"; from: -60; duration: 450; easing.type: Easing.OutCubic }
                    NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 450 }
                }

                delegate: Item {
                    required property int num

                    width: grid.cellWidth
                    height: grid.cellHeight

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 5
                        radius: 8
                        color: "#FFFFFF"
                        border.color: "#e0e0e0"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: num
                            color: "#333"
                            font.pointSize: 12
                            font.bold: true
                        }
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            text: "共 " + grid.count + " 项 ｜ 点击 footer 的按钮追加内容，header 的计数会同步变化"
            font.pointSize: 10
            color: "#666"
        }
    }
}
