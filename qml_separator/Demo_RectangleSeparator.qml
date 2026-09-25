import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Rectangle 分隔线"
            description: "使用 Rectangle 实现水平和垂直分隔线，可自定义颜色和宽度"
        }

        // 水平分隔线
        Divider {
            isVertical: false
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "lightblue"
            }

            // 垂直分隔线
            Divider {
                isVertical: true
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "lightgreen"
            }
        }

        Item { Layout.fillHeight: true }
    }
}
