import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义 BusyIndicator - 矩形缺口环"
            description: "使用 Rectangle 配合 RotationAnimation 实现带缺口的旋转加载环"
        }

        BusyIndicator {
            running: true  // 确保 BusyIndicator 是运行的
            Layout.alignment: Qt.AlignHCenter

            contentItem: Rectangle {
                implicitWidth: 120
                implicitHeight: 120
                color: "transparent"
                border.color: "#2ecc71"
                border.width: 12
                radius: width / 2

                // 添加一个缺口
                Rectangle {
                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                    width: parent.border.width
                    height: width
                    color: "#fff"
                    border.color: "transparent"
                }

                RotationAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 1000
                    loops: Animation.Infinite
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
