import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    FontLoader { id: kuaileLoader; source: "qrc:/fonts/ZCOOLKuaiLe-Regular.ttf" }

    // 度量跟着滑块的字号走
    FontMetrics {
        id: metrics
        font.family: kuaileLoader.name
        font.pointSize: sizeSlider.value
    }

    component MetricRow: RowLayout {
        property string label
        property real value

        Layout.fillWidth: true
        spacing: 8

        Text {
            text: label
            font.pointSize: 9
            color: "#9AA0A6"
            Layout.fillWidth: true
            elide: Text.ElideRight
        }

        Text {
            text: value.toFixed(1)
            font.pointSize: 11
            font.bold: true
            color: "#1296FF"
        }
    }

    // 辅助线：贴着示例文字画，标签放在线的右端
    component GuideLine: Rectangle {
        property string label
        property real lineY
        property color lineColor

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        y: lineY
        height: 1
        color: lineColor

        Text {
            x: parent.width - width
            y: -height - 2
            text: parent.label
            font.pointSize: 9
            color: parent.lineColor
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "字体度量"
            description: "FontMetrics 给出字体本身的尺寸：ascent、descent、xHeight 各有多高、基线落在哪里。灰字是 16 px 的参照，拖动滑块就能看出当前字号有多大。"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 12

            // 左：示例文字 + 辅助线
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#FFFFFF"
                border.color: "#E6E6E6"
                radius: 8
                clip: true

                // 参照文本：固定 16px，和下面的示例文字对比就能感受到字号大小
                Text {
                    x: 20
                    y: 14
                    text: "参照 16 px"
                    font.pointSize: 9
                    color: "#9AA0A6"
                }

                Text {
                    x: 20
                    y: 30
                    text: "Hxpg 字"
                    font.family: kuaileLoader.name
                    font.pointSize: 16
                    color: "#C0C6CC"
                }

                Rectangle {
                    x: 20
                    y: 76
                    width: parent.width - 40
                    height: 1
                    color: "#EEEEEE"
                }

                Item {
                    id: sample

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 92
                    anchors.bottom: parent.bottom

                    // 基线跟着字号走，让整块文字在示例区里保持居中
                    readonly property real baselineY: height / 2 + (metrics.ascent - metrics.descent) / 2

                    Text {
                        x: 20
                        y: sample.baselineY - metrics.ascent
                        text: "Hxpg 字"
                        font: metrics.font
                        color: "#333333"
                    }

                    GuideLine {
                        lineY: sample.baselineY - metrics.ascent
                        label: "ascent"
                        lineColor: "#9AA7B5"
                    }
                    GuideLine {
                        lineY: sample.baselineY
                        label: "baseline"
                        lineColor: "#5A6470"
                    }
                    GuideLine {
                        lineY: sample.baselineY + metrics.descent
                        label: "descent"
                        lineColor: "#9AA7B5"
                    }
                }
            }

            // 右：度量值
            Rectangle {
                Layout.preferredWidth: 168
                Layout.fillHeight: true
                color: "#FFFFFF"
                border.color: "#E6E6E6"
                radius: 8

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        text: "度量值 (px)"
                        font.pointSize: 10
                        font.bold: true
                        color: "#333333"
                    }

                    MetricRow { label: "ascent"; value: metrics.ascent }
                    MetricRow { label: "descent"; value: metrics.descent }
                    MetricRow { label: "height"; value: metrics.height }
                    MetricRow { label: "xHeight"; value: metrics.xHeight }
                    MetricRow { label: "lineSpacing"; value: metrics.lineSpacing }

                    Item { Layout.fillHeight: true }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Text {
                text: "字号"
                font.pointSize: 10
                color: "#7A8288"
            }

            Slider {
                id: sizeSlider
                Layout.preferredWidth: 200
                from: 12
                to: 72
                value: 40
                stepSize: 1
            }

            Text {
                text: sizeSlider.value.toFixed(0) + " px"
                font.pointSize: 10
                font.bold: true
                color: "#1296FF"
                Layout.preferredWidth: 50
            }

            Item { Layout.fillWidth: true }
        }
    }
}
