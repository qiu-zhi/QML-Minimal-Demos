import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "大数据性能优化"
            description: "自定义 popup 内 ListView 并启用 ScrollBar，处理 10000 条选项的高效滚动"
        }

        // 大型列表
        ComboBox {
            id: largeDataCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            popup: Popup {
                y: largeDataCombo.height
                width: largeDataCombo.width
                implicitHeight: Math.min(contentHeight, 150)
                padding: 1

                contentItem: ListView {
                    id: contentListView
                    clip: true
                    implicitHeight: contentHeight
                    model: largeDataCombo.popup.visible ? largeDataCombo.delegateModel : null
                    currentIndex: largeDataCombo.highlightedIndex
                    snapMode: ListView.SnapToItem
                    boundsBehavior: Flickable.StopAtBounds

                    // 使用延迟创建提高性能
                    delegate: ItemDelegate {
                        // 不能用 parent.width：model 为 null 时 ListView 会实例化测量用 delegate，其 parent 为 null
                        width: contentListView.width
                        text: modelData
                        highlighted: largeDataCombo.highlightedIndex === index
                    }

                    ScrollBar.vertical: ScrollBar { }
                }
            }

            // 模拟大数据集
            Component.onCompleted: {
                var hugeModel = []
                for (var i = 0; i < 10000; i++) {
                    hugeModel.push("选项 " + (i + 1))
                }
                largeDataCombo.model = hugeModel
            }
        }

        Text {
            id: textResult
            Layout.fillWidth: true
            color: "#333"
            font.pointSize: 11
            text: largeDataCombo.currentIndex >= 0
                  ? "当前选择: " + largeDataCombo.currentText
                  : "未选择"
        }

        Item { Layout.fillHeight: true }
    }
}
