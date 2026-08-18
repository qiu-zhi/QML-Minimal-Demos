import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ButtonGroup - 互斥单选"
            description: "exclusive: true 的按钮组一次只能选中一个；通过 ButtonGroup.group 附加属性，不同父容器下的按钮也能同属一组"
        }

        // 互斥按钮组：跨容器组织单选
        ButtonGroup {
            id: viewGroup
            exclusive: true
            onCheckedButtonChanged: {
                if (checkedButton)
                    statusText.text = "当前视图：" + checkedButton.text
            }
        }

        ColumnLayout {
            spacing: 10
            RadioButton { text: "大图标视图";   ButtonGroup.group: viewGroup; checked: true }
            RadioButton { text: "列表视图";     ButtonGroup.group: viewGroup }
            RadioButton { text: "详细信息视图"; ButtonGroup.group: viewGroup }
        }

        RowLayout {
            spacing: 20
            RadioButton { text: "平铺";     ButtonGroup.group: viewGroup }
            RadioButton { text: "内容预览";  ButtonGroup.group: viewGroup }
        }

        Text {
            id: statusText
            Layout.fillWidth: true
            color: "#1296FF"
            font.pointSize: 11
            text: "当前视图：大图标视图"
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 11
            wrapMode: Text.Wrap
            text: "提示：两组按钮位于不同父容器，但同属一个 ButtonGroup，互斥生效"
        }

        Item { Layout.fillHeight: true }
    }
}
