import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Controls.impl
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义进度条（不确定动画）"
            description: "使用 progressmask.png 蒙版图实现不确定模式下的循环条纹动画效果"
        }

        ProgressBar {
            id: control
            Layout.fillWidth: true
            height: 24
            value: 0.6

            contentItem: Item {
                scale: control.mirrored ? -1 : 1

                Rectangle {
                    height: parent.height
                    width: (control.indeterminate ? 1.0 : control.position) * parent.width

                    radius: 2
                    border.color: "#ccc"
                    color: "#1296ff"
                }

                Item {
                    x: 1; y: 1
                    width: parent.width - 2
                    height: parent.height - 2
                    visible: control.indeterminate
                    clip: true

                    ColorImage {
                        width: Math.ceil(parent.width / implicitWidth + 1) * implicitWidth
                        height: parent.height

                        mirror: control.mirrored
                        fillMode: Image.TileHorizontally
                        source: "/images/progressmask.png"
                        color: Color.transparent(Qt.lighter("#1296ff", 1.2), 160 / 255)

                        visible: control.indeterminate
                        NumberAnimation on x {
                            running: control.indeterminate && control.visible
                            from: -31 // progressmask.png width
                            to: 0
                            loops: Animation.Infinite
                            duration: 750
                        }
                    }
                }
            }

            background: Rectangle {
                radius: 2
                color: "#fff"
                border.color: "#ccc"
            }
        }

        Switch {
            text: "开启不确定模式"
            font.pointSize: 11
            checked: control.indeterminate
            onClicked: control.indeterminate = !control.indeterminate
        }

        Item { Layout.fillHeight: true }
    }
}
