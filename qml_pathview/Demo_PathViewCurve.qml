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
            title: "曲线路径"
            description: "把 PathLine 换成 PathQuad（二次贝塞尔曲线），项就沿曲线排布；拖动滑块可改控制点位置。"
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
                id: pathView
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                focus: true

                model: 10
                pathItemCount: 7
                snapMode: PathView.SnapToItem
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                highlightRangeMode: PathView.StrictlyEnforceRange

                // 两段 PathQuad 拼出上下起伏的波浪，控制点纵向偏移由下方滑块实时驱动
                path: Path {
                    startX: 0
                    startY: pathView.height / 2
                    PathQuad {
                        x: pathView.width * 0.5
                        y: pathView.height / 2
                        controlX: pathView.width * 0.25
                        controlY: pathView.height * (0.5 - waveSlider.value)
                    }
                    PathQuad {
                        x: pathView.width
                        y: pathView.height / 2
                        controlX: pathView.width * 0.75
                        controlY: pathView.height * (0.5 + waveSlider.value)
                    }
                }

                delegate: Rectangle {
                    id: dot
                    required property int index

                    width: 64
                    height: 84
                    radius: 10
                    color: PathView.isCurrentItem ? "#1976D2" : "#90caf9"
                    scale: PathView.isCurrentItem ? 1.15 : 0.9

                    Behavior on color { ColorAnimation { duration: 150 } }
                    Behavior on scale { NumberAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent
                        text: dot.index + 1
                        color: PathView.isCurrentItem ? "white" : "#1565C0"
                        font.pointSize: 16
                        font.bold: true
                    }
                }

                Keys.onLeftPressed: pathView.decrementCurrentIndex()
                Keys.onRightPressed: pathView.incrementCurrentIndex()
            }
        }

        // 控制条：调整 PathQuad 的控制点位置
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Text {
                text: "控制点偏移"
                font.pointSize: 10
                color: "#666"
            }

            Slider {
                id: waveSlider
                Layout.fillWidth: true
                from: 0.1
                to: 0.45
                value: 0.38
            }

            Text {
                Layout.preferredWidth: 36
                text: waveSlider.value.toFixed(2)
                font.pointSize: 10
                color: "#1976D2"
            }
        }
    }
}
