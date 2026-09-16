import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    readonly property int maxCount: 8
    // 先把根上下文的 C++ 模型捕获成文档根属性：context property 只能被本文档的
    // 内联对象解析，跨文件组件（CountBar）实例上的绑定读不到它，会得到 null
    readonly property var dataModel: itemModel

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "C++ 自定义模型"
            description: "继承 QAbstractListModel 实现 C++ 模型；「增加 / 减少」走 Q_INVOKABLE 的 addItem / removeLastItem，增删必须用 begin/end 包裹，Repeater 才会收到通知"
        }

        CountBar {
            info: "rowCount: " + dataModel.count
            canIncrease: dataModel.count < maxCount
            canDecrease: dataModel.count > 0
            onIncreaseRequested: dataModel.addItem()
            onDecreaseRequested: dataModel.removeLastItem()
        }

        Repeater {
            model: dataModel

            delegate: ItemRect {
                itemColor: model.color
                itemText: model.name
                itemDes: model.des
            }
        }

        Item { Layout.fillHeight: true }
    }
}
