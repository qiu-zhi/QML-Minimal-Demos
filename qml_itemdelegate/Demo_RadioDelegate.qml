import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    id: root

    // 单选组：保证同一时刻只能选中一个
    property string currentSelection: ""

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "RadioDelegate 单选列表项"
            description: "单选委托组件，同组中只能选中一个，常用于单选场景（如配送方式）"
        }

        // 内容卡片：列表垂直方向铺满剩余空间
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 2
                    ScrollBar.vertical: ScrollBar {}

                    model: ["极速达（次日到）", "标准配送（3-5天）", "经济配送（5-7天）", "门店自提", "同城闪送", "预约送达"]

                    delegate: RadioDelegate {
                        id: radioItem
                        required property string modelData
                        required property int index

                        width: ListView.view.width
                        height: 42
                        checked: index === 0
                        ButtonGroup.group: radioGroup

                        // 指示器移到最左侧，文本紧随其后；右侧留白，滚动条不再遮挡交互区
                        indicator: Item {} // 屏蔽默认的右侧圆点

                        contentItem: RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 12
                            anchors.rightMargin: 6
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 20
                                Layout.preferredHeight: 20
                                Layout.alignment: Qt.AlignVCenter
                                radius: width / 2
                                border.width: 1.5
                                border.color: radioItem.checked ? "#1976D2" : "#b6bec9"
                                color: "transparent"

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: 10
                                    height: 10
                                    radius: width / 2
                                    color: "#1976D2"
                                    visible: radioItem.checked
                                }
                            }

                            Text {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                text: radioItem.modelData
                                elide: Text.ElideRight
                                font.pointSize: 11
                                color: "#333"
                            }
                        }

                        onCheckedChanged: {
                            if (checked)
                                root.currentSelection = modelData
                        }
                    }
                }

                // 底部结果栏
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    Text {
                        Layout.fillWidth: true
                        text: root.currentSelection.length > 0
                              ? "当前选择：%1".arg(root.currentSelection)
                              : "点击任意一项完成单选"
                        elide: Text.ElideRight
                        font.pointSize: 10
                        color: "#666"
                    }
                }
            }
        }
    }

    // 单选组对象：供每个 RadioDelegate 通过 ButtonGroup.group 挂载
    ButtonGroup {
        id: radioGroup
    }
}
