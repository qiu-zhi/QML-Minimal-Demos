import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Column 垂直布局"
            description: "对比 Column（固定高度）与 ColumnLayout（自适应高度）：垂直排列、高度填充"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 30

            // Column - 垂直排列
            ColumnLayout {
                spacing: 6
                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: 140

                Text {
                    text: "Column (固定高度)"
                    font.pointSize: 11
                    font.bold: true
                    color: "#1976D2"
                }

                Rectangle {
                    Layout.preferredWidth: 140; Layout.preferredHeight: 30
                    color: "#e3f2fd"; border.color: "#90CAF9"; radius: 4
                    Text { anchors.centerIn: parent; text: "Item 1"; color: "#333" }
                }
                Rectangle {
                    Layout.preferredWidth: 140; Layout.preferredHeight: 40
                    color: "#e8f5e9"; border.color: "#A5D6A7"; radius: 4
                    Text { anchors.centerIn: parent; text: "Item 2"; color: "#333" }
                }
                Rectangle {
                    Layout.preferredWidth: 140; Layout.preferredHeight: 50
                    color: "#ffebee"; border.color: "#EF9A9A"; radius: 4
                    Text { anchors.centerIn: parent; text: "Item 3"; color: "#333" }
                }
            }

            // 分隔线
            Rectangle {
                Layout.fillHeight: true
                width: 1
                color: "#eee"
            }

            // ColumnLayout - 自适应高度
            ColumnLayout {
                spacing: 6
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 140

                Text {
                    text: "ColumnLayout (自适应)"
                    font.pointSize: 11
                    font.bold: true
                    color: "#1976D2"
                }

                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: 40
                    color: "#e3f2fd"; border.color: "#90CAF9"; radius: 4
                    Text { anchors.centerIn: parent; text: "Item 1"; color: "#333" }
                }
                Rectangle {
                    Layout.fillWidth: true; Layout.fillHeight: true
                    color: "#e8f5e9"; border.color: "#A5D6A7"; radius: 4
                    Text { anchors.centerIn: parent; text: "Fill Height"; color: "#333" }
                }
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: 40
                    color: "#ffebee"; border.color: "#EF9A9A"; radius: 4
                    Text { anchors.centerIn: parent; text: "Item 3"; color: "#333" }
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
            text: "**说明：**\n- Column: 垂直排列，子项固定高度\n- ColumnLayout: 支持高度自适应和权重分配"
        }
    }
}
