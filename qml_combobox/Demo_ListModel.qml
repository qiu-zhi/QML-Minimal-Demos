import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ListModel 动态模型"
            description: "使用 ListModel 提供多角色数据，通过 textRole 指定显示字段，访问其他角色取详情"
        }

        ListModel {
            id: cityModel
            ListElement { name: "北京"; code: "010" }
            ListElement { name: "上海"; code: "021" }
            ListElement { name: "广州"; code: "020" }
        }

        ComboBox {
            id: cityCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            model: cityModel
            textRole: "name"

            onActivated: {
                textResult.text = "选中城市代码: " + cityModel.get(currentIndex).code
            }
        }

        Text {
            id: textResult
            Layout.fillWidth: true
            color: "#333"
            font.pointSize: 11
        }

        Item { Layout.fillHeight: true }
    }
}
