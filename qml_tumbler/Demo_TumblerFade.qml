import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "透明度渐变"
            description: "通过 Tumbler.displacement 计算透明度，中间项最清晰，边缘项半透明"
        }

        Tumbler {
            id: tumbler
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200

            model: 100
            delegate: Text {
                text: modelData
                color: Tumbler.tumbler.currentIndex === index ? "red" : "black"
                font.pixelSize: 20
                font.bold: Tumbler.tumbler.currentIndex === index
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: 0.4 + Math.max(0, 1 - Math.abs(Tumbler.displacement)) * 0.6
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "当前选择: " + tumbler.currentIndex
            font.pointSize: 13
            color: "#1296FF"
            font.bold: true
        }

        Item { Layout.fillHeight: true }
    }
}
