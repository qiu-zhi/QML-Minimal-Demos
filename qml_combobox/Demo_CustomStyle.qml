import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义样式"
            description: "使用 Basic 风格，完全自定义 background、contentItem、delegate、indicator 四个组件"
        }

        ComboBox {
            id: styledCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            model: ["选项1", "选项2", "选项3"]

            // 背景样式 - 定义 ComboBox 的矩形框外观
            // 注意：不要在这里引用 styledCombo.width/height（会与 implicitWidth/Height 形成绑定循环）
            // background 默认会自动铺满整个 ComboBox，无需手动设置尺寸
            background: Rectangle {
                // 三态配色：常态白底浅蓝边框，hover 淡蓝 tint，按下更深
                color: styledCombo.down ? "#D9ECFF"
                     : (styledCombo.hovered ? "#EAF4FF" : "#FFFFFF")
                border.color: styledCombo.activeFocus ? "#1296FF"
                            : (styledCombo.hovered ? "#8FC8FF" : "#D5E4F7")
                border.width: styledCombo.activeFocus ? 2 : 1
                radius: 4
            }

            // 内容区域 - 显示当前选中的文本
            contentItem: Text {
                text: styledCombo.displayText
                font: styledCombo.font
                color: "#1F2D3D"
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
                rightPadding: styledCombo.indicator.width + 15
            }

            // 下拉列表项样式 - 定义弹出窗口中每个选项的外观
            delegate: ItemDelegate {
                width: styledCombo.width
                height: 30

                // 选项内容文本：当前选中项用主色加粗高亮
                // 注意：font 是 group property，不能用 font: xxx 整体赋值后再改子属性（会报重复赋值）
                contentItem: Text {
                    text: modelData
                    font.family: styledCombo.font.family
                    font.pixelSize: styledCombo.font.pixelSize
                    font.weight: parent.highlighted ? Font.DemiBold : Font.Normal
                    color: parent.highlighted ? "#1296FF" : "#1F2D3D"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 10
                    rightPadding: 10
                }

                // 选项背景：选中项浅蓝高亮，hover/down 淡蓝
                background: Rectangle {
                    color: parent.highlighted ? "#EAF4FF"
                         : (parent.down ? "#D9ECFF" : (parent.hovered ? "#F0F8FF" : "transparent"))
                }
            }

            // 下拉箭头指示器 - 自定义箭头样式
            indicator: Canvas {
                x: styledCombo.width - width - 8
                y: styledCombo.topPadding + (styledCombo.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"

                // 绘制箭头
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()
                    // 箭头颜色：跟随主色，hover/down 时加深
                    ctx.strokeStyle = (styledCombo.hovered || styledCombo.down) ? "#0B7CDB" : "#1296FF"
                    // 线条宽度
                    ctx.lineWidth = 2
                    ctx.beginPath()
                    // 绘制三角形箭头路径
                    // 起点：左上角
                    ctx.moveTo(0, 0)
                    // 中点：底部中心
                    ctx.lineTo(width / 2, height)
                    // 终点：右上角
                    ctx.lineTo(width, 0)
                    // 描边绘制
                    ctx.stroke()
                }
            }
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：自定义了背景、内容文本、下拉项和箭头四个部分"
        }

        Item { Layout.fillHeight: true }
    }
}
