import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "时钟可视化"
            description: "使用 Canvas 绘制模拟时钟，表盘中间显示年月日"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 30

                Canvas {
                    id: clockCanvas
                    Layout.preferredWidth: 280
                    Layout.preferredHeight: 280
                    Layout.alignment: Qt.AlignVCenter

                    property date now: new Date()

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: {
                            clockCanvas.now = new Date()
                            clockCanvas.requestPaint()
                        }
                    }

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()

                        var w = width
                        var h = height
                        var cx = w / 2
                        var cy = h / 2
                        var r = Math.min(cx, cy) - 10

                        var gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, r)
                        gradient.addColorStop(0, "#fff")
                        gradient.addColorStop(1, "#fafafa")
                        ctx.fillStyle = gradient
                        ctx.beginPath()
                        ctx.arc(cx, cy, r, 0, Math.PI * 2)
                        ctx.fill()

                        ctx.strokeStyle = "#e0e0e0"
                        ctx.lineWidth = 1
                        ctx.beginPath()
                        ctx.arc(cx, cy, r, 0, Math.PI * 2)
                        ctx.stroke()

                        ctx.strokeStyle = "#333"
                        ctx.lineWidth = 2
                        ctx.beginPath()
                        ctx.arc(cx, cy, r - 2, 0, Math.PI * 2)
                        ctx.stroke()

                        for (var i = 0; i < 60; i++) {
                            var angle = (i * 6 - 90) * Math.PI / 180
                            var isHour = (i % 5 === 0)
                            var outerR = r - 6
                            var innerR = isHour ? r - 20 : r - 12
                            var x1 = cx + outerR * Math.cos(angle)
                            var y1 = cy + outerR * Math.sin(angle)
                            var x2 = cx + innerR * Math.cos(angle)
                            var y2 = cy + innerR * Math.sin(angle)

                            ctx.strokeStyle = isHour ? "#333" : "#ccc"
                            ctx.lineWidth = isHour ? 2.5 : 1
                            ctx.beginPath()
                            ctx.moveTo(x1, y1)
                            ctx.lineTo(x2, y2)
                            ctx.stroke()
                        }

                        for (var h2 = 1; h2 <= 12; h2++) {
                            var numAngle = (h2 * 30 - 90) * Math.PI / 180
                            var numR = r - 36
                            var nx = cx + numR * Math.cos(numAngle)
                            var ny = cy + numR * Math.sin(numAngle)

                            ctx.fillStyle = "#333"
                            ctx.font = "bold 15px sans-serif"
                            ctx.textAlign = "center"
                            ctx.textBaseline = "middle"
                            ctx.fillText(h2.toString(), nx, ny)
                        }

                        var hours = now.getHours()
                        var minutes = now.getMinutes()
                        var seconds = now.getSeconds()

                        var hourAngle = ((hours % 12) + minutes / 60) * 30 - 90
                        var hourRad = hourAngle * Math.PI / 180
                        var hourLen = r * 0.5
                        ctx.strokeStyle = "#333"
                        ctx.lineWidth = 5
                        ctx.lineCap = "round"
                        ctx.beginPath()
                        ctx.moveTo(cx, cy)
                        ctx.lineTo(cx + hourLen * Math.cos(hourRad), cy + hourLen * Math.sin(hourRad))
                        ctx.stroke()

                        var minAngle = (minutes + seconds / 60) * 6 - 90
                        var minRad = minAngle * Math.PI / 180
                        var minLen = r * 0.7
                        ctx.strokeStyle = "#555"
                        ctx.lineWidth = 3.5
                        ctx.beginPath()
                        ctx.moveTo(cx, cy)
                        ctx.lineTo(cx + minLen * Math.cos(minRad), cy + minLen * Math.sin(minRad))
                        ctx.stroke()

                        var secAngle = seconds * 6 - 90
                        var secRad = secAngle * Math.PI / 180
                        var secLen = r * 0.8
                        ctx.strokeStyle = "#e74c3c"
                        ctx.lineWidth = 2
                        ctx.beginPath()
                        ctx.moveTo(cx, cy)
                        ctx.lineTo(cx + secLen * Math.cos(secRad), cy + secLen * Math.sin(secRad))
                        ctx.stroke()

                        ctx.fillStyle = "#e74c3c"
                        ctx.beginPath()
                        ctx.arc(cx, cy, 6, 0, Math.PI * 2)
                        ctx.fill()

                        ctx.fillStyle = "#fff"
                        ctx.beginPath()
                        ctx.arc(cx, cy, 3, 0, Math.PI * 2)
                        ctx.fill()

                        var dateStr = Qt.formatDate(now, "yyyy-MM-dd")
                        ctx.fillStyle = "#666"
                        ctx.font = "bold 11px sans-serif"
                        ctx.textAlign = "center"
                        ctx.textBaseline = "middle"
                        ctx.fillText(dateStr, cx, cy + 45)
                    }

                    Component.onCompleted: requestPaint()
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "transparent"

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 12

                        Text {
                            id: digitalTime
                            property date d: clockCanvas.now
                            text: Qt.formatTime(d, "hh:mm:ss")
                            font.pixelSize: 32
                            font.bold: true
                            color: "#333"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Text {
                            id: digitalDate
                            property date d: clockCanvas.now
                            text: d.toLocaleDateString(Qt.locale(), Locale.LongFormat)
                            font.pixelSize: 13
                            color: "#888"
                            Layout.alignment: Qt.AlignHCenter
                        }

                        Rectangle {
                            Layout.preferredWidth: 180
                            Layout.preferredHeight: 1
                            color: "#e0e0e0"
                        }

                        Text {
                            text: "**Canvas 2D 绘制表盘和指针**\n- Timer 每秒刷新\n- 时针: (时+分/60)×30°\n- 分针: (分+秒/60)×6°\n- 秒针: 秒×6°"
                            font.pixelSize: 13
                            color: "#666"
                            textFormat: Text.MarkdownText
                        }
                    }
                }
            }
        }
    }
}
