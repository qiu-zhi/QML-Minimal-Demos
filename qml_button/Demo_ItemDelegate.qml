import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ItemDelegate - 列表项按钮"
            description: "ListView 中的项按钮，常用于列表选择"
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            model: ["按钮1", "按钮2", "按钮3", "按钮4", "按钮5"]
            delegate: ItemDelegate {
                // enabled: false
                text: modelData
                width: listView.width
                onClicked: textResult.text = "clicked: " + modelData
            }
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        Text {
            id: textResult
            Layout.alignment: Qt.AlignLeft
        }

        Item { Layout.fillHeight: true }
    }
}
