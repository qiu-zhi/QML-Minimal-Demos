import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            text: "Qt.SplashScreen - 启动画面"
            font.pointSize: 16
            font.bold: true
            color: "#333"
        }

        Text {
            text: "演示 Qt.SplashScreen 标志位：无边框启动画面，点击任意位置关闭"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
        }

        Button {
            text: "打开 Qt.SplashScreen 窗口"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: splashWindow.visible = true
        }

        Item { Layout.fillHeight: true }
    }

    Window {
        id: splashWindow
        width: 350
        height: 200
        flags: Qt.SplashScreen
        color: "#FF9800"

        MouseArea {
            anchors.fill: parent
            onClicked: splashWindow.close()
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20

            Text {
                text: "Qt.SplashScreen"
                font.pointSize: 14
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "无边框启动画面\n点击任意位置关闭"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
