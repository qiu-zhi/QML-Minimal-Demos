import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义分隔线"
            description: "使用 Repeater 组合 Rectangle 实现虚线样式的自定义分隔线"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "lightpink"
            }

            // 自定义虚线分隔线
            Item {
                Layout.fillHeight: true
                width: 20

                Column {
                    anchors.centerIn: parent
                    spacing: 4
                    Repeater {
                        model: 5
                        Rectangle {
                            width: 4
                            height: 4
                            radius: 2
                            color: "darkgray"
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "lightyellow"
            }
        }
    }
}
