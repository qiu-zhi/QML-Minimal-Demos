import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    FontLoader { id: kuaileLoader; source: "qrc:/fonts/ZCOOLKuaiLe-Regular.ttf" }

    // text 一改，宽度和边界框全部重算
    TextMetrics {
        id: tm
        font.family: kuaileLoader.name
        font.pointSize: 22
        text: input.text
        elide: Text.ElideRight
        elideWidth: 120
    }

    // 借 FontMetrics 拿基线，好把边界框对到文字上
    FontMetrics {
        id: fm
        font: tm.font
    }

    component MetricRow: RowLayout {
        property string label
        property string value

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
            text: value
            font.pointSize: 11
            font.bold: true
            color: "#1296FF"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "文本度量"
            description: "TextMetrics 量的是某一小段文字排出来有多宽、边界框多大。它比 FontMetrics 多了一个 text，数值跟着文字内容变。"
        }

        TextField {
            id: input
            Layout.fillWidth: true
            text: "QML 文本度量"
            placeholderText: "输入要测量的文字"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 12

            // 左：把两个边界框画在文字上
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#FFFFFF"
                border.color: "#E6E6E6"
                radius: 8
                clip: true

                // 图例：小方框的颜色和两个边界框对应
                Column {
                    x: 20
                    y: 12
                    spacing: 3

                    Row {
                        spacing: 6

                        Rectangle {
                            y: 3
                            width: 9
                            height: 9
                            color: "transparent"
                            border.color: "#1296FF"
                        }

                        Text {
                            text: "boundingRect"
                            font.pointSize: 9
                            color: "#9AA0A6"
                        }
                    }

                    Row {
                        spacing: 6

                        Rectangle {
                            y: 3
                            width: 9
                            height: 9
                            color: "transparent"
                            border.color: "#E67E22"
                        }

                        Text {
                            text: "tightBoundingRect"
                            font.pointSize: 9
                            color: "#9AA0A6"
                        }
                    }
                }

                // 文字和边界框上下居中摆放，跟着文字长度一起动
                Item {
                    id: drawArea

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 52
                    anchors.bottom: band.top

                    Text {
                        id: rawText
                        x: 28
                        anchors.verticalCenter: parent.verticalCenter
                        text: tm.text
                        font: tm.font
                        color: "#333333"
                    }

                    // 偏松：带上下留白
                    Rectangle {
                        x: rawText.x + tm.boundingRect.x
                        y: rawText.y + fm.ascent + tm.boundingRect.y
                        width: tm.boundingRect.width
                        height: tm.boundingRect.height
                        color: "transparent"
                        border.color: "#1296FF"
                    }

                    // 贴紧字形本身
                    Rectangle {
                        x: rawText.x + tm.tightBoundingRect.x
                        y: rawText.y + fm.ascent + tm.tightBoundingRect.y
                        width: tm.tightBoundingRect.width
                        height: tm.tightBoundingRect.height
                        color: "transparent"
                        border.color: "#E67E22"
                    }
                }

                // 省略结果单独占一条底栏
                Rectangle {
                    id: band

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 36
                    color: "#F7F8FA"

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 14
                        anchors.rightMargin: 14
                        text: "elideWidth 120 px 省略后：" + tm.elidedText
                        font.pointSize: 10
                        color: "#666666"
                        elide: Text.ElideRight
                    }
                }
            }

            // 右：度量值
            Rectangle {
                Layout.preferredWidth: 230
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

                    MetricRow { label: "advanceWidth"; value: tm.advanceWidth.toFixed(1) }
                    MetricRow { label: "width"; value: tm.width.toFixed(1) }
                    MetricRow { label: "height"; value: tm.height.toFixed(1) }
                    MetricRow {
                        label: "boundingRect"
                        value: tm.boundingRect.width.toFixed(1) + " × " + tm.boundingRect.height.toFixed(1)
                    }
                    MetricRow {
                        label: "tightBoundingRect"
                        value: tm.tightBoundingRect.width.toFixed(1) + " × " + tm.tightBoundingRect.height.toFixed(1)
                    }

                    Item { Layout.fillHeight: true }
                }
            }
        }
    }
}
