import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 内容卡片：声明在布局之外，具体位置由代理来接管
    Rectangle {
        id: cardA
        implicitWidth: 160
        implicitHeight: 100
        radius: 8
        color: "#1296FF"
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            anchors.centerIn: parent
            text: "卡片 A"
            color: "white"
            font.pointSize: 14
            font.bold: true
        }
    }

    Rectangle {
        id: cardB
        implicitWidth: 160
        implicitHeight: 100
        radius: 8
        color: "#26A69A"
        Layout.fillWidth: true
        Layout.fillHeight: true

        Text {
            anchors.centerIn: parent
            text: "卡片 B"
            color: "white"
            font.pointSize: 14
            font.bold: true
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "布局代理"
            description: "LayoutItemProxy 是布局里的占位符，代表布局之外的 Item。同一份内容可声明一次，在多个布局里各放一个代理，靠可见性切换换排布。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Switch {
                id: twoCols
                text: "两列布局"
                checked: false
            }

            Text {
                text: twoCols.checked ? "当前：两列并排" : "当前：单列堆叠"
                color: "#666"
                font.pointSize: 10
            }

            Item { Layout.fillWidth: true }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FFFFFF"
            border.color: "#e0e0e0"
            radius: 8
            clip: true

            GridLayout {
                anchors.fill: parent
                anchors.margins: 16
                columns: 1
                visible: !twoCols.checked

                LayoutItemProxy { target: cardA }
                LayoutItemProxy { target: cardB }
            }

            GridLayout {
                anchors.fill: parent
                anchors.margins: 16
                columns: 2
                visible: twoCols.checked

                LayoutItemProxy { target: cardA }
                LayoutItemProxy { target: cardB }
            }
        }
    }
}
