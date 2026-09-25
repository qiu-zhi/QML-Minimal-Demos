import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "环形轮播"
            description: "把路径闭合成整圆，所有项常驻圆周；切换当前项时视图会沿圆周旋转，形成旋转木马。"
        }

        // 内容卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            PathView {
                id: carousel
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                focus: true

                // 圆环按可视区自适应；1.32 = 1 + 圆点半径占比，保证圆点顶部刚好贴住留白
                readonly property real ringRadius: (Math.min(width, height) / 2 - 8) / 1.32
                // 圆点尺寸由环半径推导（8 个点相邻弦长约为 0.765r），这样窗口无论放大缩小都不会互相挤压
                readonly property real dotSize: ringRadius * 0.55

                model: 8
                pathItemCount: 8
                snapMode: PathView.SnapOneItem
                preferredHighlightBegin: 0
                preferredHighlightEnd: 0
                highlightRangeMode: PathView.StrictlyEnforceRange

                path: Path {
                    startX: carousel.width / 2
                    startY: carousel.height / 2 - carousel.ringRadius
                    PathAngleArc {
                        centerX: carousel.width / 2
                        centerY: carousel.height / 2
                        radiusX: carousel.ringRadius
                        radiusY: carousel.ringRadius
                        startAngle: -90
                        sweepAngle: 360
                        moveToStart: true
                    }
                }

                delegate: Rectangle {
                    id: tile
                    required property int index

                    width: carousel.dotSize
                    height: carousel.dotSize
                    radius: width / 2
                    color: PathView.isCurrentItem ? "#1976D2" : "#bdc3c7"
                    scale: PathView.isCurrentItem ? 1.15 : 0.85

                    Behavior on color { ColorAnimation { duration: 200 } }
                    Behavior on scale { NumberAnimation { duration: 200 } }

                    Text {
                        anchors.centerIn: parent
                        text: tile.index + 1
                        font.pointSize: carousel.dotSize * 0.28
                        font.bold: true
                        color: "white"
                    }
                }

                Keys.onLeftPressed: carousel.decrementCurrentIndex()
                Keys.onRightPressed: carousel.incrementCurrentIndex()
            }

            // 圆心信息
            Column {
                anchors.centerIn: parent
                spacing: 2

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: carousel.currentIndex + 1
                    font.pointSize: carousel.dotSize * 0.62
                    font.bold: true
                    color: "#1976D2"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "共 " + carousel.count + " 项"
                    font.pointSize: carousel.dotSize * 0.19
                    color: "#999"
                }
            }
        }

        // 控制条
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Switch {
                id: autoSwitch
                text: "自动轮播"
                font.pointSize: 10
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "上一个"
                font.pointSize: 10
                onClicked: carousel.decrementCurrentIndex()
            }

            Button {
                text: "下一个"
                font.pointSize: 10
                onClicked: carousel.incrementCurrentIndex()
            }
        }
    }

    Timer {
        interval: 1200
        repeat: true
        running: autoSwitch.checked
        onTriggered: carousel.incrementCurrentIndex()
    }
}
