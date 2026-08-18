import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        id: root
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        property string currentName: "无"

        TitleSeparator {
            title: "Tab 顺序导航"
            description: "默认情况下 QML 按 ActiveFocusOnTab 标记与子项声明顺序进行 Tab/Shift+Tab 导航"
        }

        // 表单：演示 Tab 默认顺序
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 220
            radius: 8
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1

            GridLayout {
                anchors.fill: parent
                anchors.margins: 14
                columns: 2
                columnSpacing: 16
                rowSpacing: 10

                Label { text: "用户名："; font.pointSize: 11; color: "#666" }
                TextField {
                    id: f1
                    Layout.fillWidth: true
                    placeholderText: "Tab 顺序 1"
                    activeFocusOnTab: true
                    onActiveFocusChanged: { if (activeFocus) root.currentName = "用户名" }
                }

                Label { text: "邮箱："; font.pointSize: 11; color: "#666" }
                TextField {
                    id: f2
                    Layout.fillWidth: true
                    placeholderText: "Tab 顺序 2"
                    activeFocusOnTab: true
                    onActiveFocusChanged: { if (activeFocus) root.currentName = "邮箱" }
                }

                Label { text: "电话："; font.pointSize: 11; color: "#666" }
                TextField {
                    id: f3
                    Layout.fillWidth: true
                    placeholderText: "Tab 顺序 3"
                    activeFocusOnTab: true
                    onActiveFocusChanged: { if (activeFocus) root.currentName = "电话" }
                }

                Label { text: "地址："; font.pointSize: 11; color: "#666" }
                TextField {
                    id: f4
                    Layout.fillWidth: true
                    placeholderText: "Tab 顺序 4"
                    activeFocusOnTab: true
                    onActiveFocusChanged: { if (activeFocus) root.currentName = "地址" }
                }
            }
        }

        Text {
            text: "当前焦点：" + root.currentName
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
