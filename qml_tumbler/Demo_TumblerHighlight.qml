import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "高亮背景"
            description: "手动添加高亮矩形固定在 Tumbler 中间位置，强调当前选中项"
        }

        Tumbler {
            id: tumbler
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200

            model: ["S", "M", "L", "XL", "XXL"]

            // 手动添加高亮矩形
            Rectangle {
                parent: tumbler.contentItem
                width: tumbler.width
                height: tumbler.height / tumbler.visibleItemCount
                color: "#21be2b"
                opacity: 0.3
                radius: 5
                y: Math.floor(tumbler.height / 2 - height / 2)  // 固定在中间
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "当前选择: " + tumbler.model[tumbler.currentIndex]
            font.pointSize: 13
            color: "#21be2b"
            font.bold: true
        }

        Item { Layout.fillHeight: true }
    }
}
