import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

FadeInAnimation {
    id: root

    // 开关状态的数据源（仅作为 TableModel 的初始行数据）
    property var settingsData: [
        { name: "自动保存文档", enabled: true,  progress: 1.0 },
        { name: "拼写检查",     enabled: false, progress: 0.0 },
        { name: "云端同步",     enabled: true,  progress: 0.6 },
        { name: "同步书签",     enabled: true,  progress: 0.35 }
    ]

    function setEnabled(rowIndex, value) {
        // setData 只会触发第 1 列那一格的更新，整表其它列不重建，解决了第一列闪烁的问题
        tableModel.setData(tableModel.index(rowIndex, 1), value, "display")
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        TitleSeparator {
            title: "按列选择委托"
            description: "DelegateChoice 的 column 属性专为 TableView 设计：同一张表的 0、1、2 列分别被渲染为文本、开关与进度条，开关可点击"
        }

        // 内容区：垂直方向填满剩余空间
        Rectangle {
            id: card
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            readonly property var colWidths: [170, 90, 220]

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 6

                // 简易表头，宽度与下方各列保持一致
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 0

                    Text {
                        Layout.preferredWidth: card.colWidths[0]
                        text: "功能"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#1296FF"
                    }
                    Text {
                        Layout.preferredWidth: card.colWidths[1]
                        text: "启用"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#1296FF"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        Layout.preferredWidth: card.colWidths[2]
                        text: "进度"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#1296FF"
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: "#e0e0e0"
                }

                TableView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    rowSpacing: 6
                    columnSpacing: 0
                    columnWidthProvider: function (column) { return card.colWidths[column] }
                    rowHeightProvider: function () { return 40 }
                    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

                    model: TableModel {
                        id: tableModel
                        TableModelColumn { display: "name" }
                        TableModelColumn { display: "enabled" }
                        TableModelColumn { display: "progress" }
                        rows: root.settingsData
                    }

                    delegate: DelegateChooser {
                        // 第 0 列：纯文本
                        DelegateChoice {
                            column: 0
                            delegate: Text {
                                required property var display
                                text: display
                                font.pixelSize: 14
                                color: "#333"
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }
                        }
                        // 第 1 列：可点击的开关，切换后写回数据源
                        DelegateChoice {
                            column: 1
                            delegate: Item {
                                required property var display
                                Switch {
                                    anchors.centerIn: parent
                                    checked: parent.display
                                    onToggled: root.setEnabled(row, checked)
                                }
                            }
                        }
                        // 第 2 列：进度条控件
                        DelegateChoice {
                            column: 2
                            delegate: ProgressBar {
                                required property var display
                                value: display
                                from: 0
                                to: 1
                            }
                        }
                    }
                }
            }
        }
    }
}
