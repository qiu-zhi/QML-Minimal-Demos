import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本对齐"
            description: "演示文本对齐方式：horizontalAlignment（水平）和 verticalAlignment（垂直）"
        }

        Repeater {
            model: [
                { text: "左对齐 (默认)", hAlign: Text.AlignLeft, vAlign: Text.AlignVCenter, height: 32 },
                { text: "居中对齐", hAlign: Text.AlignHCenter, vAlign: Text.AlignVCenter, height: 32 },
                { text: "右对齐", hAlign: Text.AlignRight, vAlign: Text.AlignVCenter, height: 32 },
                { text: "垂直置顶", hAlign: Text.AlignLeft, vAlign: Text.AlignTop, height: 40 },
                { text: "垂直居中", hAlign: Text.AlignLeft, vAlign: Text.AlignVCenter, height: 40 },
                { text: "垂直底部", hAlign: Text.AlignLeft, vAlign: Text.AlignBottom, height: 40 },
                { text: "水平+垂直居中", hAlign: Text.AlignHCenter, vAlign: Text.AlignVCenter, height: 40 }
            ]

            Rectangle {
                width: 200
                height: modelData.height
                color: "#f5f5f5"
                border.color: "#ddd"

                Text {
                    anchors.fill: parent
                    anchors.margins: 4
                    text: modelData.text
                    horizontalAlignment: modelData.hAlign
                    verticalAlignment: modelData.vAlign
                    font.pointSize: 11
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
