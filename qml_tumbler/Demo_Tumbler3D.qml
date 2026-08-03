import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "3D 旋转"
            description: "结合 Rotation 旋转与 Scale 缩放，营造 3D 滚轮视觉"
        }

        Tumbler {
            id: tumbler
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 200

            Rectangle {
                anchors.fill: parent
                color: "#FFFFFF"
                radius: 5
                z: -1
            }

            model: 50
            delegate: Text {
                id: delegateText
                text: modelData
                color: "#333"
                font.pixelSize: 16 + (1 - Math.abs(delegateText.Tumbler.displacement)) * 10
                font.bold: delegateText.Tumbler.tumbler.currentIndex === index
                opacity: 0.5 + (1 - Math.abs(delegateText.Tumbler.displacement)) * 0.5
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                width: 100  // 确保文本居中
                transform: [
                    Rotation {
                        origin.x: width / 2
                        origin.y: height / 2
                        axis { x: 1; y: 0; z: 0 }
                        angle: delegateText.Tumbler.displacement * 30
                    },
                    Scale {
                        origin.x: width / 2
                        origin.y: height / 2
                        xScale: 1.0 - Math.abs(delegateText.Tumbler.displacement) * 0.2
                        yScale: 1.0 - Math.abs(delegateText.Tumbler.displacement) * 0.2
                    }
                ]
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
