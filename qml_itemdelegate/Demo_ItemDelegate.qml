import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ItemDelegate 点击列表项"
            description: "基础委托组件，用于展示可点击的列表项，支持高亮选中状态"
        }

        // 内容卡片：列表垂直方向铺满剩余空间
        Rectangle {
            id: panel
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ListView {
                id: listView
                anchors.fill: parent
                anchors.margins: 8
                clip: true
                spacing: 4
                ScrollBar.vertical: ScrollBar {}

                model: 8
                delegate: ItemDelegate {
                    required property int index

                    text: "选项 " + (index + 1)
                    width: ListView.view.width
                    height: 44
                    highlighted: ListView.isCurrentItem
                    onClicked: ListView.view.currentIndex = index
                }
            }
        }
    }
}
