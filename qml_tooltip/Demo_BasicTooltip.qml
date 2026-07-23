import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础 Tooltip"
            description: "使用 ToolTip 附加类型在悬停时展示提示，可设置延迟与超时时间"
        }

        RowLayout {
            Layout.preferredHeight: 120
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Rectangle {
                Layout.preferredWidth: 120
                Layout.preferredHeight: 40
                color: "lightblue"
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: "基础 Tooltip"
                }

                ToolTip {
                    text: "这是一个基础的tooltip示例"
                    delay: 500
                    timeout: 5000
                    visible: basicMA.hovered
                }

                HoverHandler {
                    id: basicMA
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
