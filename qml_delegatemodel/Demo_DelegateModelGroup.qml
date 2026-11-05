import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

FadeInAnimation {
    id: root

    ListModel {
        id: taskModel
        ListElement { task: "整理会议纪要" }
        ListElement { task: "修复登录问题" }
        ListElement { task: "补充接口文档" }
        ListElement { task: "评审设计稿" }
        ListElement { task: "排查线上告警" }
    }

    DelegateModel {
        id: taskDelegateModel
        model: taskModel
        filterOnGroup: "items"

        groups: [
            DelegateModelGroup { id: starGroup; name: "star"; includeByDefault: false }
        ]

        delegate: Rectangle {
            id: row
            required property int index
            required property string task

            width: lv.width
            height: 46
            color: row.DelegateModel.inStar ? "#FFF6E0" : "#FFFFFF"
            border.color: "#EAEAEA"
            border.width: 1

            Text {
                x: 12
                anchors.verticalCenter: parent.verticalCenter
                text: row.DelegateModel.inStar ? "★" : "☆"
                color: row.DelegateModel.inStar ? "#F5A623" : "#BBB"
                font.pointSize: 14
            }

            Text {
                x: 40
                anchors.verticalCenter: parent.verticalCenter
                text: row.task
                color: "#333"
                font.pointSize: 12
            }

            MouseArea {
                anchors.fill: parent
                onClicked: row.DelegateModel.inStar = !row.DelegateModel.inStar
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "分组过滤"
            description: "groups 把同一份模型切出子集，filterOnGroup 决定视图只显示哪一组；点击条目即可切换它所属的组。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Button {
                id: allBtn
                text: "全部"
                font.pointSize: 10
                checkable: true
                checked: true
                onClicked: {
                    taskDelegateModel.filterOnGroup = "items"
                    allBtn.checked = true
                    starBtn.checked = false
                }
            }

            Button {
                id: starBtn
                text: "已标记"
                font.pointSize: 10
                checkable: true
                onClicked: {
                    taskDelegateModel.filterOnGroup = "star"
                    allBtn.checked = false
                    starBtn.checked = true
                }
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "全部 " + taskDelegateModel.items.count + " 项 ｜ 已标记 " + starGroup.count + " 项"
                color: "#666"
                font.pointSize: 10
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FAFAFA"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ListView {
                id: lv
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                model: taskDelegateModel
            }
        }
    }
}
