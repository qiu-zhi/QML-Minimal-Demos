import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Row 水平布局"
            description: "对比 Row（固定布局）与 RowLayout（自适应布局）：间距、子项大小、填充宽度"
        }

        // Row - 固定布局
        Text {
            text: "Row - 固定布局"
            font.pointSize: 11
            font.bold: true
            color: "#1976D2"
        }

        Row {
            spacing: 10
            Rectangle {
                width: 60; height: 60
                color: "#e3f2fd"; border.color: "#90CAF9"; radius: 4
                Text { anchors.centerIn: parent; text: "Item1"; color: "#333" }
            }
            Rectangle {
                width: 100; height: 60
                color: "#e8f5e9"; border.color: "#A5D6A7"; radius: 4
                Text { anchors.centerIn: parent; text: "Item2"; color: "#333" }
            }
            Rectangle {
                width: 80; height: 60
                color: "#ffebee"; border.color: "#EF9A9A"; radius: 4
                Text { anchors.centerIn: parent; text: "Item3"; color: "#333" }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#eee"
        }

        // RowLayout - 自适应布局
        Text {
            text: "RowLayout - 自适应布局"
            font.pointSize: 11
            font.bold: true
            color: "#1976D2"
        }

        RowLayout {
            spacing: 10
            Layout.fillWidth: true

            Rectangle {
                Layout.preferredWidth: 60; Layout.preferredHeight: 60
                color: "#e3f2fd"; border.color: "#90CAF9"; radius: 4
                Text { anchors.centerIn: parent; text: "Item1"; color: "#333" }
            }
            Rectangle {
                Layout.fillWidth: true; Layout.preferredHeight: 60
                color: "#e8f5e9"; border.color: "#A5D6A7"; radius: 4
                Text { anchors.centerIn: parent; text: "Fill Width"; color: "#333" }
            }
            Rectangle {
                Layout.preferredWidth: 100; Layout.preferredHeight: 60
                color: "#ffebee"; border.color: "#EF9A9A"; radius: 4
                Text { anchors.centerIn: parent; text: "Item3"; color: "#333" }
            }
        }

        Item { Layout.fillHeight: true }

        // 说明
        Note {
            text: "**说明：**\n- Row: 固定间距，子项固定大小，超出父容器不会换行\n- RowLayout: 自适应布局，支持 Layout.fillWidth 和权重分配"
        }
    }
}
