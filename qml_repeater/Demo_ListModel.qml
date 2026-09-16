import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    readonly property var colors: ["#3498db", "#e74c3c", "#2ecc71", "#f39c12"]
    readonly property int maxCount: 8

    // 提到外面，方便操作条直接调用 append / remove
    ListModel {
        id: listModel
        ListElement { name: "Item1"; color: "#3498db"; des: "model.des" }
        ListElement { name: "Item2"; color: "#e74c3c"; des: "model.des" }
        ListElement { name: "Item3"; color: "#2ecc71"; des: "model.des" }
        ListElement { name: "Item4"; color: "#f39c12"; des: "model.des" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "ListModel"
            description: "QML 内置的 ListModel 定义结构化数据，通过 model.role 访问；「增加」走 append，「减少」走 remove，自带变更通知"
        }

        CountBar {
            info: "count: " + listModel.count
            canIncrease: listModel.count < maxCount
            canDecrease: listModel.count > 0
            onIncreaseRequested: listModel.append({
                name: "Item" + (listModel.count + 1),
                color: colors[listModel.count % colors.length],
                des: "model.des"
            })
            onDecreaseRequested: listModel.remove(listModel.count - 1)
        }

        Repeater {
            model: listModel

            delegate: ItemRect {
                itemColor: model.color
                itemText: model.name
                itemDes: model.des
            }
        }

        Item { Layout.fillHeight: true }
    }
}
