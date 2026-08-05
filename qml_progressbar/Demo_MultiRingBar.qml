import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "多环进度条"
            description: "多层同心圆环进度条，常用于多指标数据对比展示"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            spacing: 30
            Layout.alignment: Qt.AlignHCenter

            // 三环进度
            ColumnLayout {
                spacing: 6
                Layout.alignment: Qt.AlignHCenter

                Text { text: "三环进度"; font.pointSize: 11; font.bold: true; color: "#555"; Layout.alignment: Qt.AlignHCenter }

                Canvas {
                    id: multiCanvas1
                    Layout.preferredWidth: 180
                    Layout.preferredHeight: 180

                    property real p1: slider1.value
                    property real p2: slider2.value
                    property real p3: slider3.value

                    onP1Changed: requestPaint()
                    onP2Changed: requestPaint()
                    onP3Changed: requestPaint()

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        var cx = width / 2, cy = height / 2
                        var rings = [
                            { r: 75, progress: p3, color: "#6C5CE7", bg: "#E0E0E0" },
                            { r: 58, progress: p2, color: "#00B894", bg: "#E0E0E0" },
                            { r: 41, progress: p1, color: "#E17055", bg: "#E0E0E0" }
                        ]
                        for (var i = 0; i < rings.length; i++) {
                            var ring = rings[i]
                            // 背景
                            ctx.beginPath()
                            ctx.arc(cx, cy, ring.r, 0, Math.PI * 2)
                            ctx.strokeStyle = ring.bg
                            ctx.lineWidth = 10
                            ctx.stroke()
                            // 进度
                            ctx.beginPath()
                            ctx.arc(cx, cy, ring.r, -Math.PI / 2, -Math.PI / 2 + Math.PI * 2 * ring.progress)
                            ctx.strokeStyle = ring.color
                            ctx.lineWidth = 10
                            ctx.lineCap = "round"
                            ctx.stroke()
                        }
                        // 中心数值
                        ctx.fillStyle = "#333"
                        ctx.font = "bold 20px sans-serif"
                        ctx.textAlign = "center"
                        ctx.textBaseline = "middle"
                        ctx.fillText(Math.round(p2 * 100), cx, cy - 6)
                        ctx.fillStyle = "#999"
                        ctx.font = "10px sans-serif"
                        ctx.fillText("综合", cx, cy + 14)
                    }
                }
            }

            // 图例 + 滑块
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 12

                RowLayout {
                    spacing: 8
                    Rectangle { width: 12; height: 12; radius: 6; color: "#E17055" }
                    Text { text: "CPU"; font.pointSize: 10; color: "#555" }
                    Text { text: Math.round(slider1.value * 100) + "%"; font.pointSize: 10; font.bold: true; color: "#E17055" }
                }
                Slider { id: slider1; from: 0; to: 1; value: 0.65; Layout.preferredWidth: 150 }

                RowLayout {
                    spacing: 8
                    Rectangle { width: 12; height: 12; radius: 6; color: "#00B894" }
                    Text { text: "内存"; font.pointSize: 10; color: "#555" }
                    Text { text: Math.round(slider2.value * 100) + "%"; font.pointSize: 10; font.bold: true; color: "#00B894" }
                }
                Slider { id: slider2; from: 0; to: 1; value: 0.78; Layout.preferredWidth: 150 }

                RowLayout {
                    spacing: 8
                    Rectangle { width: 12; height: 12; radius: 6; color: "#6C5CE7" }
                    Text { text: "磁盘"; font.pointSize: 10; color: "#555" }
                    Text { text: Math.round(slider3.value * 100) + "%"; font.pointSize: 10; font.bold: true; color: "#6C5CE7" }
                }
                Slider { id: slider3; from: 0; to: 1; value: 0.45; Layout.preferredWidth: 150 }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
