import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义按钮"
            description: "使用 MouseArea 实现完整的按钮交互：悬停变色、按下缩放、释放回弹"
        }

        // 自定义按钮
        Rectangle {
            id: btn
            Layout.alignment: Qt.AlignHCenter
            width: 140
            height: 50
            radius: 8
            color: mouseArea.pressed ? "#0E7BD9" : (mouseArea.containsMouse ? "#3FA9F5" : "#1296FF")
            scale: mouseArea.pressed ? 0.95 : 1.0

            Behavior on scale {
                NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            Text {
                anchors.centerIn: parent
                text: "自定义按钮"
                color: "white"
                font.pointSize: 13
                font.bold: true
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: btn.clickCount++
            }

            property int clickCount: 0
        }


        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "矩形按钮点击: " + btn.clickCount + " 次"
            font.pointSize: 12
            color: "#999"
        }

        // 圆角图标按钮
        Rectangle {
            id: iconBtn
            Layout.alignment: Qt.AlignHCenter
            width: 50
            height: 50
            radius: 25
            color: iconMouse.pressed ? "#E8910C" : (iconMouse.containsMouse ? "#FFB74D" : "#FF9800")
            scale: iconMouse.pressed ? 0.9 : 1.0

            Behavior on scale {
                NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            Text {
                anchors.centerIn: parent
                text: "+"
                color: "white"
                font.pointSize: 24
                font.bold: true
            }

            MouseArea {
                id: iconMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: iconBtn.iconClickCount++
            }

            property int iconClickCount: 0
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "圆形按钮点击: " + iconBtn.iconClickCount + " 次"
            font.pointSize: 12
            color: "#999"
        }

        Item { Layout.fillHeight: true }
    }
}
