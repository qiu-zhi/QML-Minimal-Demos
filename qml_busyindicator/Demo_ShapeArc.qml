import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义 BusyIndicator - Shape 圆弧"
            description: "使用 QtQuick.Shapes 绘制圆弧，配合动画实现加载效果"
        }

        BusyIndicator {
            id: control
            running: true
            Layout.alignment: Qt.AlignHCenter

            contentItem: Item {
                implicitWidth: 120
                implicitHeight: 120
                x: (control.availableWidth - width) / 2
                y: (control.availableHeight - height) / 2

                property Shape ring: Shape {
                    parent: control.contentItem
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2
                    implicitWidth: parent.implicitWidth
                    implicitHeight: parent.implicitHeight
                    width: Math.min(control.contentItem.width, control.contentItem.height)
                    height: width
                    preferredRendererType: Shape.CurveRenderer
                    // antialiasing: true

                    ShapePath {
                        fillColor: "transparent"
                        strokeColor: "#3498db"
                        strokeWidth: control.contentItem.ring.width >= 64 ? 6 : control.contentItem.ring.width <= 16 ? 1 : 3

                        capStyle: ShapePath.RoundCap

                        PathAngleArc {
                            centerX: control.contentItem.ring.width / 2
                            centerY: control.contentItem.ring.height / 2
                            radiusX: control.contentItem.ring.width / 2 - 2
                            radiusY: radiusX
                            startAngle: -90
                            sweepAngle: 120

                            SequentialAnimation on startAngle {
                                loops: Animation.Infinite
                                running: control.visible && control.running
                                NumberAnimation { from: 0; to: 450; duration: 1000 }
                                NumberAnimation { from: 450; to: 1080; duration: 1000 }
                            }

                            SequentialAnimation on sweepAngle {
                                loops: Animation.Infinite
                                running: control.visible && control.running
                                NumberAnimation { from: 0; to: 180; duration: 1000 }
                                NumberAnimation { from: 180; to: 0; duration: 1000 }
                            }
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
