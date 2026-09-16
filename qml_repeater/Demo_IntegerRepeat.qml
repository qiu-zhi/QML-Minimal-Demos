import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    // 整数模型：改这个值，Repeater 就会增删委托实例
    // 注意不能命名为 count —— Repeater 自带只读 count（当前项数），会把它遮蔽
    property int modelCount: 4
    readonly property int maxCount: 8

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "整数作为模型"
            description: "model 直接写一个整数，Repeater 就创建对应数量的委托；「增加 / 减少」改变 model 值，委托里用 index 取序号（小数会四舍五入）"
        }

        CountBar {
            info: "model: " + modelCount
            canIncrease: modelCount < maxCount
            canDecrease: modelCount > 0
            onIncreaseRequested: modelCount++
            onDecreaseRequested: modelCount--
        }

        Repeater {
            model: modelCount

            delegate: Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                radius: 6
                color: "#f5f5f5"
                border.color: "#ccc"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "Item" + index
                    color: "#333"
                    font.pointSize: 10
                    font.bold: true
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
