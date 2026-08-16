import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义显示文本"
            description: "通过 displayText 属性自定义显示格式，结合模型对象的多字段拼接展示"
        }

        ComboBox {
            id: priceCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            model: [
                { id: 1, name: "苹果", price: 5.8 },
                { id: 2, name: "香蕉", price: 3.2 }
            ]
            textRole: "name"
            displayText: currentText + (currentIndex >= 0 ? " - ¥" + model[currentIndex].price : "")
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "当前显示: " + (priceCombo.currentIndex >= 0 ? priceCombo.displayText : "未选择")
        }

        Item { Layout.fillHeight: true }
    }
}
