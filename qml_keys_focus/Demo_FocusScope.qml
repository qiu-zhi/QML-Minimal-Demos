import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "FocusScope 焦点作用域"
            description: "FocusScope 将内部多个子项封装为一个焦点目标，切换后内部焦点自动保留"
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            // 面板 A
            FocusScope {
                id: panelA
                width: 240; height: 160

                Rectangle {
                    anchors.fill: parent
                    radius: 10
                    color: panelA.activeFocus ? "#EAF4FF" : "#FAFAFA"
                    border.color: panelA.activeFocus ? "#1296FF" : "#ccc"
                    border.width: panelA.activeFocus ? 2 : 1

                    Column {
                        anchors.centerIn: parent
                        spacing: 8
                        Text { text: "面板 A"; font.pointSize: 14; font.bold: true; color: panelA.activeFocus ? "#1296FF" : "#666"; anchors.horizontalCenter: parent.horizontalCenter }
                        TextField { width: 180; placeholderText: "输入框 1"; focus: true }
                        TextField { width: 180; placeholderText: "输入框 2" }
                    }
                }

                MouseArea { anchors.fill: parent; onClicked: panelA.forceActiveFocus() }
            }

            // 面板 B
            FocusScope {
                id: panelB
                width: 240; height: 160

                Rectangle {
                    anchors.fill: parent
                    radius: 10
                    color: panelB.activeFocus ? "#EAF4FF" : "#FAFAFA"
                    border.color: panelB.activeFocus ? "#1296FF" : "#ccc"
                    border.width: panelB.activeFocus ? 2 : 1

                    Column {
                        anchors.centerIn: parent
                        spacing: 8
                        Text { text: "面板 B"; font.pointSize: 14; font.bold: true; color: panelB.activeFocus ? "#1296FF" : "#666"; anchors.horizontalCenter: parent.horizontalCenter }
                        TextField { width: 180; placeholderText: "输入框 1"; focus: true }
                        TextField { width: 180; placeholderText: "输入框 2" }
                    }
                }

                MouseArea { anchors.fill: parent; onClicked: panelB.forceActiveFocus() }
            }
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10
            Button { text: "聚焦面板 A"; onClicked: panelA.forceActiveFocus() }
            Button { text: "聚焦面板 B"; onClicked: panelB.forceActiveFocus() }
        }

        Text {
            text: "说明：切换面板后切回，输入框焦点仍在原位置"
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
