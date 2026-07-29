import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        id: root
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        property color tickColor: "#606060"
        property color activeTickColor: "#e74c3c"
        property int tickCount: 10
        property int subTickCount: 4
        property double startAngle: -140
        property double endAngle: 140

        TitleSeparator {
            title: "带刻度的 Dial"
            description: "使用 Canvas 绘制主刻度、子刻度与高亮指示线，配合中心数值显示"
        }

        Dial {
            id: dial
            Layout.alignment: Qt.AlignHCenter
            width: 240
            height: 240
            from: 0
            to: 100
            value: 50
            stepSize: 1

            // 隐藏默认handle
            handle: null

            background: Canvas {
                id: dialCanvas
                anchors.fill: parent
                rotation: -90

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    const centerX = width / 2
                    const centerY = height / 2
                    const outerRadius = width / 2 - 10
                    const innerRadius = outerRadius - 15
                    const subInnerRadius = outerRadius - 8

                    // 绘制主刻度
                    ctx.strokeStyle = root.tickColor
                    ctx.lineWidth = 1.5
                    for (var i = 0; i <= root.tickCount; i++) {
                        var angle = (root.startAngle + (root.endAngle - root.startAngle) * (i / root.tickCount)) * Math.PI / 180

                        ctx.beginPath()
                        ctx.moveTo(
                                    centerX + innerRadius * Math.cos(angle),
                                    centerY + innerRadius * Math.sin(angle)
                                    )
                        ctx.lineTo(
                                    centerX + outerRadius * Math.cos(angle),
                                    centerY + outerRadius * Math.sin(angle)
                                    )
                        ctx.stroke()

                        // 绘制刻度标签
                        ctx.fillStyle = root.tickColor
                        ctx.font = '12px sans-serif'
                        ctx.textAlign = "center"
                        ctx.textBaseline = "middle"
                        var labelRadius = outerRadius - 25
                        var labelValue = dial.from + (dial.to - dial.from) * (i / root.tickCount)

                        ctx.save()
                        ctx.translate(
                                    centerX + labelRadius * Math.cos(angle),
                                    centerY + labelRadius * Math.sin(angle)
                                    )
                        ctx.rotate(angle + Math.PI/2)
                        ctx.fillText(labelValue.toFixed(0), 0, 0)
                        ctx.restore()
                    }

                    // 绘制子刻度
                    if (root.subTickCount > 0) {
                        ctx.lineWidth = 1
                        for (i = 0; i <= root.tickCount * root.subTickCount; i++) {
                            angle = (root.startAngle + (root.endAngle - root.startAngle) * (i / (root.tickCount * root.subTickCount))) * Math.PI / 180
                            if (i % root.subTickCount === 0) continue

                            ctx.beginPath()
                            ctx.moveTo(centerX + subInnerRadius * Math.cos(angle), centerY + subInnerRadius * Math.sin(angle))
                            ctx.lineTo(centerX + outerRadius * Math.cos(angle), centerY + outerRadius * Math.sin(angle))
                            ctx.stroke()
                        }
                    }

                    // 高亮当前值刻度（指示线）
                    var activeAngle = dial.angle * Math.PI / 180
                    ctx.strokeStyle = root.activeTickColor
                    ctx.lineWidth = 2
                    ctx.beginPath()
                    ctx.moveTo(centerX + (innerRadius-10) * Math.cos(activeAngle), centerY + (innerRadius-10) * Math.sin(activeAngle))
                    ctx.lineTo(centerX + outerRadius * Math.cos(activeAngle), centerY + outerRadius * Math.sin(activeAngle))
                    ctx.stroke()
                }

                Connections {
                    target: dial
                    function onValueChanged() { dialCanvas.requestPaint() }
                }
            }

            // 中心值显示（带背景提升可读性）
            Rectangle {
                anchors.centerIn: parent
                width: valueLabel.width + 20
                height: valueLabel.height + 10
                radius: 5
                color: "#f0f0f0"
                border.color: "#ccc"

                Label {
                    id: valueLabel
                    anchors.centerIn: parent
                    text: dial.value.toFixed(1)
                    font.pointSize: 12
                    color: root.activeTickColor
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
