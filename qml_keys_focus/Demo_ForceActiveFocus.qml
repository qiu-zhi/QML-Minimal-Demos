import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "forceActiveFocus()"
            description: "主动夺取焦点，无视 focus 声明，常用于按钮点击后切回输入框等场景"
        }

        // 目标区域
        Rectangle {
            id: target
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            radius: 10
            color: target.activeFocus ? "#EAF4FF" : "#FAFAFA"
            border.color: target.activeFocus ? "#1296FF" : "#ccc"
            border.width: target.activeFocus ? 2 : 1

            property int count: 0
            onActiveFocusChanged: { if (activeFocus) count++ }

            Text {
                anchors.centerIn: parent
                text: target.activeFocus
                      ? "已获取焦点（第 " + target.count + " 次）"
                      : "未获得焦点"
                font.pointSize: 14
                color: target.activeFocus ? "#1296FF" : "#999"
                font.bold: true
            }
        }

        // 操作按钮
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            Button {
                text: "获取焦点"
                onClicked: target.forceActiveFocus()
            }
            Button {
                text: "失去焦点"
                onClicked: holder.forceActiveFocus()
            }
        }

        // 隐藏的占位项，用于接收焦点
        Item { id: holder; visible: false; focus: false }

        Item { Layout.fillHeight: true }
    }
}
