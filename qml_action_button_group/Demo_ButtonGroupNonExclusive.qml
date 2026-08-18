import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ButtonGroup - 多选与父子联动"
            description: "exclusive: false 时支持多选；配合 tri-state CheckBox 实现父子三态联动（全选/部分选/全不选）"
        }

        // 非互斥组：父子双向绑定 checkState
        ButtonGroup {
            id: featureGroup
            exclusive: false
            checkState: parentBox.checkState
            buttons: childColumn.children
        }

        CheckBox {
            id: parentBox
            text: "功能开关（父节点）"
            tristate: true
            checkState: featureGroup.checkState
            Layout.alignment: Qt.AlignLeft
            onCheckStateChanged: {
                var s = checkState === Qt.Checked ? "全选"
                      : checkState === Qt.PartiallyChecked ? "部分选中"
                      : "全不选"
                statusText.text = "父节点状态：" + s
            }
        }

        ColumnLayout {
            id: childColumn
            Layout.leftMargin: 30
            spacing: 10
            CheckBox { text: "代码高亮" }
            CheckBox { text: "行号显示"; checked: true }
            CheckBox { text: "自动缩进" }
            CheckBox { text: "括号匹配"; checked: true }
            CheckBox { text: "拼写检查" }
        }

        Text {
            id: statusText
            Layout.fillWidth: true
            color: "#1296FF"
            font.pointSize: 11
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 11
            wrapMode: Text.Wrap
            text: "提示：父节点 tri-state 双向绑定，子节点全部选中时父自动勾选，部分选中时父显示半选状态"
        }

        Item { Layout.fillHeight: true }
    }
}