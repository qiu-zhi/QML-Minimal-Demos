import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    // 字符串数组：元素本身就是 modelData
    property var items: ["Item1", "Item2", "Item3", "Item4"]
    readonly property int maxCount: 8

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "字符串数组"
            description: "字符串数组作为模型，modelData 直接就是字符串值；「增加 / 减少」改变数组长度"
        }

        CountBar {
            info: "数组长度: " + items.length
            canIncrease: items.length < maxCount
            canDecrease: items.length > 0
            // var 属性只有「重新赋值」才会发变更通知，push / pop 原地改数组不会刷新
            onIncreaseRequested: items = items.concat("Item" + (items.length + 1))
            onDecreaseRequested: items = items.slice(0, -1)
        }

        Repeater {
            model: items

            delegate: Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                radius: 6
                color: "#f5f5f5"
                border.color: "#ccc"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    color: "#333"
                    font.pointSize: 10
                    font.bold: true
                    text: modelData
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
