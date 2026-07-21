import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Grid 网格布局"
            description: "对比 Grid（简单网格）与 GridLayout（支持跨行跨列、自适应大小）"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 30

            // Grid 示例 - 固定网格
            ColumnLayout {
                spacing: 8
                Layout.alignment: Qt.AlignTop

                Text {
                    text: "Grid - 固定网格"
                    font.pointSize: 11
                    font.bold: true
                    color: "#1976D2"
                }

                Grid {
                    columns: 3
                    spacing: 5

                    Repeater {
                        model: 9
                        Rectangle {
                            width: 55; height: 55
                            color: (index % 2 === 0) ? "#e3f2fd" : "#e8f5e9"
                            border.color: (index % 2 === 0) ? "#90CAF9" : "#A5D6A7"
                            radius: 4
                            Text { anchors.centerIn: parent; text: (index + 1); color: "#333" }
                        }
                    }
                }
            }

            // 分隔线
            Rectangle {
                Layout.fillHeight: true
                width: 1
                color: "#eee"
            }

            // GridLayout 示例 - 自适应网格
            ColumnLayout {
                spacing: 8
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    text: "GridLayout - 跨行跨列"
                    font.pointSize: 11
                    font.bold: true
                    color: "#1976D2"
                }

                GridLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    columns: 3
                    rowSpacing: 5
                    columnSpacing: 5

                    Rectangle {
                        Layout.column: 0; Layout.row: 0
                        Layout.fillWidth: true; Layout.fillHeight: true
                        color: "#e3f2fd"; border.color: "#90CAF9"; radius: 4
                        Text { anchors.centerIn: parent; text: "1"; color: "#333" }
                    }
                    Rectangle {
                        Layout.column: 1; Layout.row: 0; Layout.columnSpan: 2
                        Layout.fillWidth: true; Layout.fillHeight: true
                        color: "#e8f5e9"; border.color: "#A5D6A7"; radius: 4
                        Text { anchors.centerIn: parent; text: "2 (跨2列)"; color: "#333" }
                    }
                    Rectangle {
                        Layout.column: 0; Layout.row: 1; Layout.rowSpan: 2
                        Layout.fillWidth: true; Layout.fillHeight: true
                        color: "#ffebee"; border.color: "#EF9A9A"; radius: 4
                        Text { anchors.centerIn: parent; text: "3 (跨2行)"; color: "#333" }
                    }
                    Rectangle {
                        Layout.column: 1; Layout.row: 1
                        Layout.fillWidth: true; Layout.fillHeight: true
                        color: "#fff8e1"; border.color: "#FFE082"; radius: 4
                        Text { anchors.centerIn: parent; text: "4"; color: "#333" }
                    }
                    Rectangle {
                        Layout.column: 2; Layout.row: 1
                        Layout.fillWidth: true; Layout.fillHeight: true
                        color: "#fce4ec"; border.color: "#F48FB1"; radius: 4
                        Text { anchors.centerIn: parent; text: "5"; color: "#333" }
                    }
                    Rectangle {
                        Layout.column: 1; Layout.row: 2; Layout.columnSpan: 2
                        Layout.fillWidth: true; Layout.fillHeight: true
                        color: "#f3e5f5"; border.color: "#CE93D8"; radius: 4
                        Text { anchors.centerIn: parent; text: "6 (底部跨2列)"; color: "#333" }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#eee"
        }

        // 说明
        Note {
            text: "**说明：**\n- Grid: 简单网格布局，子项固定大小\n- GridLayout: 支持跨行跨列、自适应大小和复杂网格布局"
        }
    }
}
