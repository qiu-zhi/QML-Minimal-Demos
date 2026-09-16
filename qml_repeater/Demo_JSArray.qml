import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    property var itemList: [
        { name: "Item1", color: "#3498db", des: "modelData.des" },
        { name: "Item2", color: "#e74c3c", des: "modelData.des" },
        { name: "Item3", color: "#2ecc71", des: "modelData.des" },
        { name: "Item4", color: "#f39c12", des: "modelData.des" }
    ]

    readonly property var colors: ["#3498db", "#e74c3c", "#2ecc71", "#f39c12"]
    readonly property int maxCount: 8

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "JavaScript 数组"
            description: "JavaScript 数组作为模型，通过 modelData 访问元素数据；「增加 / 减少」改变数组长度"
        }

        CountBar {
            info: "数组长度: " + itemList.length
            canIncrease: itemList.length < maxCount
            canDecrease: itemList.length > 0
            // var 属性只有「重新赋值」才会发变更通知，push / splice 原地改数组不会刷新
            onIncreaseRequested: {
                var next = itemList.length
                itemList = itemList.concat({
                    name: "Item" + (next + 1),
                    color: colors[next % colors.length],
                    des: "modelData.des"
                })
            }
            onDecreaseRequested: itemList = itemList.slice(0, -1)
        }

        Repeater {
            model: itemList

            delegate: ItemRect {
                itemColor: modelData.color
                itemText: modelData.name
                itemDes: modelData.des
            }
        }

        Item { Layout.fillHeight: true }
    }
}
