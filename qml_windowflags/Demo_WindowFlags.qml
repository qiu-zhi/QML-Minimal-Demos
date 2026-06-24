import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            text: "窗口标志位 (Window Flags)"
            font.pointSize: 16
            font.bold: true
            color: "#333"
        }

        Text {
            text: "演示各种窗口标志位：控制窗口的外观和行为"
            font.pointSize: 10
            color: "#666"
            wrapMode: Text.WordWrap
        }

        GridLayout {
            columns: 2
            columnSpacing: 10
            rowSpacing: 10
            Layout.fillWidth: true

            Button {
                text: "Qt.Tool"
                Layout.fillWidth: true
                onClicked: toolWindow.visible = true
            }

            Button {
                text: "Qt.ToolTip"
                Layout.fillWidth: true
                onClicked: tooltipWindow.visible = true
            }

            Button {
                text: "Qt.SplashScreen"
                Layout.fillWidth: true
                onClicked: splashWindow.visible = true
            }

            Button {
                text: "Qt.Frameless"
                Layout.fillWidth: true
                onClicked: framelessWindow.visible = true
            }

            Button {
                text: "Qt.StayOnTop"
                Layout.fillWidth: true
                onClicked: topWindow.visible = true
            }

            Button {
                text: "Qt.Dialog"
                Layout.fillWidth: true
                onClicked: dialogWindow.visible = true
            }
        }

        Item { Layout.fillHeight: true }
    }

    // Qt.Tool: 工具窗口
    Window {
        id: toolWindow
        title: "Qt.Tool"
        width: 300
        height: 200
        flags: Qt.Tool
        color: "#2196F3"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.Tool"
                font.pointSize: 14
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "窄标题栏工具窗口\n任务栏不显示独立图标"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Qt.ToolTip: 提示窗口
    Window {
        id: tooltipWindow
        width: 250
        height: 100
        flags: Qt.ToolTip
        color: "#4CAF50"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.ToolTip"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "无边框浮动提示窗口"
                font.pointSize: 11
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Qt.SplashScreen: 启动画面
    Window {
        id: splashWindow
        width: 350
        height: 200
        flags: Qt.SplashScreen
        color: "#FF9800"

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
                text: "无边框启动画面\n通常用于应用启动时显示"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Qt.FramelessWindowHint: 无边框窗口
    Window {
        id: framelessWindow
        title: "无边框窗口"
        width: 300
        height: 200
        flags: Qt.FramelessWindowHint
        color: "#9C27B0"

        MouseArea {
            anchors.fill: parent
            onPressed: framelessWindow.startSystemMove()
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.FramelessWindowHint"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "完全无边框窗口\n拖拽任意位置可移动"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Qt.WindowStaysOnTopHint: 置顶窗口
    Window {
        id: topWindow
        title: "置顶窗口"
        width: 300
        height: 200
        flags: Qt.WindowStaysOnTopHint
        color: "#F44336"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.WindowStaysOnTopHint"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "始终在最上层窗口\n不会被其他窗口覆盖"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Qt.Dialog: 对话框窗口
    Window {
        id: dialogWindow
        title: "Qt.Dialog"
        width: 300
        height: 200
        flags: Qt.Dialog
        color: "#607D8B"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15

            Text {
                text: "Qt.Dialog"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "对话框样式窗口\n可模态或非模态"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
