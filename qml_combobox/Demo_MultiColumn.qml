import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "多列 ComboBox"
            description: "在 delegate 中使用 Row 布局多个 Text，实现名称、代码、区域多列展示"
        }

        ComboBox {
            id: multiColumnCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            delegate: ItemDelegate {
                width: multiColumnCombo.width
                Row {
                    spacing: 10
                    Text {
                        text: modelData.name
                        width: 100
                        elide: Text.ElideRight
                    }
                    Text {
                        text: modelData.code
                        width: 50
                        color: "gray"
                    }
                    Text {
                        text: modelData.region
                        width: 100
                        color: "gray"
                    }
                }
            }

            model: [
                { name: "北京", code: "010", region: "华北" },
                { name: "上海", code: "021", region: "华东" },
                { name: "广州", code: "020", region: "华南" }
            ]

            displayText: currentText + " (" + model[currentIndex].code + ")"
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：下拉列表中每行显示名称、代码、区域三列"
        }

        Item { Layout.fillHeight: true }
    }
}
