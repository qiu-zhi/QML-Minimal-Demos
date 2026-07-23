import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "CheckBox - 复选框"
            description: "多选框，支持父子联动和 ButtonGroup 管理"
        }

        ButtonGroup {
            id: childGroup
            exclusive: false
            checkState: parentBox.checkState
            buttons: childColumn.children
        }

        CheckBox {
            id: parentBox
            text: "父节点"
            checkState: childGroup.checkState
            Layout.alignment: Qt.AlignLeft
        }

        Column {
            id: childColumn
            Layout.leftMargin: 15
            Layout.alignment: Qt.AlignLeft
            spacing: 15

            CheckBox { text: "子节点 1" }
            CheckBox { text: "子节点 2" }
        }

        Item { Layout.fillHeight: true }
    }
}
