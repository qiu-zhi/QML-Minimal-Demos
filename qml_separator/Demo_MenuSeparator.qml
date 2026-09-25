import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "菜单分隔线"
            description: "MenuSeparator 用于在弹出菜单中分隔不同分组的菜单项"
        }

        Menu {
            id: menu
            width: 120
            MenuItem { text: "复制" }
            MenuItem { text: "粘贴" }
            MenuSeparator { }
            MenuItem { text: "设置" }
            MenuItem { text: "帮助" }
        }

        Button {
            text: "点击显示菜单"
            onClicked: menu.popup()
        }

        Item { Layout.fillHeight: true }
    }
}
