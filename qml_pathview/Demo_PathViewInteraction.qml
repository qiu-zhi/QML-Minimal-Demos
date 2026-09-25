import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    id: root

    // 下拉项：Basic 样式在选中项上会改用白色文字，这里显式指定配色
    component OptionItem: ItemDelegate {
        id: optionItem
        required property int index
        required property string modelData

        width: parent ? parent.width : 0
        font.pointSize: 10
        highlighted: ListView.isCurrentItem

        contentItem: Text {
            text: optionItem.modelData
            font: optionItem.font
            color: optionItem.highlighted ? "#1565C0" : "#333"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            color: optionItem.highlighted ? "#e3f2fd" : "transparent"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "吸附对齐"
            description: "红线是吸附目标，当前项用底色标出。这里关掉了 Qt 默认的区间限制，否则位置会被锁在中间。"
        }

        // 内容卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            // 吸附目标线：水平用锚点严格居中，垂直贯穿整个区域，即 preferredHighlightBegin 所在的位置
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 2
                color: "#e74c3c"
                opacity: 0.45
            }

            PathView {
                id: pathView
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                focus: true

                model: 12
                // 间距 = 路径长 ÷ pathItemCount，卡片宽度要明显小于间距才不会挤在一起
                pathItemCount: 4
                // 吸附目标：让项与路径中点对齐
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                // 刻意不用 Qt 默认的 StrictlyEnforceRange：那会把位置锁死在中间，吸附模式就没效果了
                highlightRangeMode: PathView.NoHighlightRange
                // SnapOneItem（松手最多挪一项）只有快速甩动时才和 SnapToItem 有区别，
                // 慢速拖动下两者结果完全一致，放进示例只会让人以为功能重复，所以不列出来
                snapMode: snapCombo.currentIndex === 0 ? PathView.SnapToItem : PathView.NoSnap

                path: Path {
                    startX: 0
                    startY: pathView.height / 2
                    PathLine {
                        x: pathView.width
                        y: pathView.height / 2
                    }
                }

                // 当前项只用底色标记，不额外套方框
                delegate: Rectangle {
                    id: panel
                    required property int index

                    width: 84
                    height: 104
                    radius: 8
                    color: PathView.isCurrentItem ? "#1976D2" : "#ffffff"
                    border.width: 1
                    border.color: PathView.isCurrentItem ? "#0d47a1" : "#dcdcdc"

                    Text {
                        anchors.centerIn: parent
                        text: panel.index + 1
                        font.pointSize: 18
                        font.bold: true
                        color: PathView.isCurrentItem ? "white" : "#8a99aa"
                    }

                    // 点击卡片直接跳转：用 PathView.view 附加属性拿到所属视图
                    MouseArea {
                        anchors.fill: parent
                        onClicked: panel.PathView.view.currentIndex = panel.index
                    }
                }

                // PathView 自身不处理滚轮，交给 WheelHandler 接管
                WheelHandler {
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                    target: null
                    onWheel: (event) => {
                        if (event.angleDelta.y < 0)
                            pathView.incrementCurrentIndex()
                        else if (event.angleDelta.y > 0)
                            pathView.decrementCurrentIndex()
                    }
                }

                Keys.onLeftPressed: pathView.decrementCurrentIndex()
                Keys.onRightPressed: pathView.incrementCurrentIndex()
                Keys.onUpPressed: pathView.decrementCurrentIndex()
                Keys.onDownPressed: pathView.incrementCurrentIndex()
            }
        }

        // 控制条：吸附模式 + 翻页
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Text {
                text: "吸附模式"
                font.pointSize: 10
                color: "#666"
            }

            ComboBox {
                id: snapCombo
                Layout.preferredWidth: 180
                font.pointSize: 10
                model: ["SnapToItem（吸附）", "NoSnap（不吸附）"]
                delegate: OptionItem {}
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "上一个"
                font.pointSize: 10
                onClicked: pathView.decrementCurrentIndex()
            }

            Button {
                text: "下一个"
                font.pointSize: 10
                onClicked: pathView.incrementCurrentIndex()
            }
        }

        // 状态读数
        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            Text {
                text: "当前项：index " + pathView.currentIndex
                font.pointSize: 10
                color: "#999"
            }

            Text {
                text: "状态：" + (pathView.dragging ? "拖动中" : (pathView.flicking ? "滑行中" : "已静止"))
                font.pointSize: 10
                color: "#999"
            }
        }
    }
}
