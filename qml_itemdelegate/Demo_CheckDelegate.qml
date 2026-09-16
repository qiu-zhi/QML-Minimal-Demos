import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    id: root

    // 记录已勾选的项
    property var selectedItems: []

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "CheckDelegate 复选列表项"
            description: "复选委托组件，可多选并获取选中项，常用于多项选择列表"
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

                    model: ["阅读", "音乐", "摄影", "旅行", "编程", "运动", "美食", "绘画"]

                    delegate: CheckDelegate {
                        id: checkItem
                        required property string modelData

                        width: ListView.view.width
                        height: 42

                        // 指示器移到最左侧，文本紧随其后；右侧留白，滚动条不再遮挡交互区
                        indicator: Item {} // 屏蔽默认的右侧勾选框

                        contentItem: RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 12
                            anchors.rightMargin: 6
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 20
                                Layout.preferredHeight: 20
                                Layout.alignment: Qt.AlignVCenter
                                radius: 4
                                border.width: 1.5
                                border.color: checkItem.checked ? "#1976D2" : "#b6bec9"
                                color: checkItem.checked ? "#1976D2" : "transparent"
                                Behavior on color { ColorAnimation { duration: 120 } }

                                Text {
                                    anchors.centerIn: parent
                                    text: "✓"
                                    color: "white"
                                    font.pixelSize: 12
                                    font.bold: true
                                    visible: checkItem.checked
                                }
                            }

                            Text {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                text: checkItem.modelData
                                elide: Text.ElideRight
                                font.pointSize: 11
                                color: "#333"
                            }
                        }

                        onCheckedChanged: {
                            if (checked) {
                                root.selectedItems.push(modelData)
                            } else {
                                root.selectedItems = root.selectedItems.filter(item => item !== modelData)
                            }
                        }
                    }
                }

                // 底部结果栏
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10

                    Button {
                        text: "获取已选项"
                        onClicked: resultLabel.text = "已选 %1 项：%2".arg(root.selectedItems.length).arg(root.selectedItems.join("、"))
                    }

                    Text {
                        id: resultLabel
                        Layout.fillWidth: true
                        text: "点击上方按钮查看勾选结果"
                        elide: Text.ElideRight
                        font.pointSize: 10
                        color: "#666"
                    }
                }
            }
        }
    }
}
