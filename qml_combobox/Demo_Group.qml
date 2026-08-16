import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "分组 ComboBox"
            description: "使用 isGroup 标记分组项，通过自定义 delegate 实现分组展示与可选项目隔离"
        }

        ComboBox {
            id: comboBox
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            // 优化后的模型结构 - 统一使用display属性，用isGroup标记分组项
            model: [
                { display: "水果", isGroup: true },
                { display: "苹果", isGroup: false },
                { display: "香蕉", isGroup: false },
                { display: "蔬菜", isGroup: true },
                { display: "胡萝卜", isGroup: false },
                { display: "西红柿", isGroup: false }
            ]

            // 当前显示文本
            displayText: currentIndex >= 0 ? model[currentIndex].display : "请选择"

            // 初始不选择任何项
            currentIndex: -1

            // 优化后的委托实现
            delegate: ItemDelegate {
                width: comboBox.width
                height: modelData.isGroup ? 30 : implicitHeight  // 分组标题高度较小
                enabled: !modelData.isGroup  // 分组项不可选择
                highlighted: comboBox.highlightedIndex === index && !modelData.isGroup

                contentItem: Text {
                    text: modelData.display
                    font.bold: modelData.isGroup
                    color: modelData.isGroup ? "#999999" : (highlighted ? "#666666" : "#333333")
                    leftPadding: modelData.isGroup ? 10 : 20  // 分组项缩进较少
                }

                // 分组项的背景色
                background: Rectangle {
                    color: modelData.isGroup ? "#f0f0f0" : "#ffffff"
                    radius: 2
                }

                // 处理点击事件，跳过分组项
                onClicked: {
                    if (!modelData.isGroup) {
                        comboBox.currentIndex = index
                        comboBox.popup.close()
                    }
                }
            }

            // 下拉框弹出时的样式调整
            popup: Popup {
                y: comboBox.height
                width: comboBox.width
                implicitHeight: 90
                padding: 1

                contentItem: ListView {
                    id: groupListView
                    clip: true
                    implicitHeight: contentHeight
                    model: comboBox.popup.visible ? comboBox.delegateModel : null
                    currentIndex: comboBox.highlightedIndex

                    // 添加分组分隔线
                    section {
                        property: "isGroup"
                        criteria: ViewSection.FullString
                        delegate: Rectangle {
                            width: groupListView.width
                            height: 1
                            color: "#eeeeee"
                            visible: section !== "true"  // 只在分组之间显示分隔线
                        }
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            color: "#333"
            font.pointSize: 11
            text: "当前选择: " + (comboBox.currentIndex >= 0 ? comboBox.displayText : "无")
        }

        Item { Layout.fillHeight: true }
    }
}
