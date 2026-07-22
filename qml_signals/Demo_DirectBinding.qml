import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    property string respMsg: ""

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "直接绑定"
            description: "通过 onValueChanged 直接绑定信号处理器，最基础的信号响应方式"
        }

        // 信号发送端
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            color: "#fff"
            border.color: "#ccc"
            border.width: 1
            radius: 6

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Text {
                    text: "请移动滑块触发信号: "
                    color: "#333"
                    font.pointSize: 12
                    font.bold: true
                }

                Slider {
                    id: slider
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: 50

                    onValueChanged: {
                        root.respMsg = "滑块数值:" + value.toFixed(2)
                    }
                }

                Text {
                    id: textReceiver
                    text: root.respMsg || "等待显示响应数据 ..."
                    font.pointSize: 11
                    color: "#3498db"
                    wrapMode: Text.WordWrap
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
