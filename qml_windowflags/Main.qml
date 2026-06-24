import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 750
    height: 520
    title: "Window & Popup Demo"
    color: "#f5f5f5"

    // 顶部标题栏
    header: ToolBar {
        background: Rectangle { color: "#1976D2" }
        Label {
            text: "Window & Popup Demo"
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.centerIn: parent
        }
    }

    // 底部状态栏
    footer: ToolBar {
        background: Rectangle { color: "#f5f5f5"; border.color: "#ddd"; border.width: 1 }
        Label {
            id: statusLabel
            text: "点击按钮查看效果"
            color: "#666"
            font.pointSize: 10
            anchors.centerIn: parent
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        // 左侧：弹窗示例
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: "弹窗示例"
                font.pointSize: 13
                font.bold: true
                color: "#333"
            }

            // 1. Popup
            Button {
                text: "Popup 弹窗"
                Layout.fillWidth: true
                onClicked: {
                    basicPopup.open()
                    statusLabel.text = "Popup: 轻量级弹出层，常用于菜单、提示"
                }
            }

            // 2. Dialog
            Button {
                text: "Dialog 对话框"
                Layout.fillWidth: true
                onClicked: {
                    dialog.open()
                    statusLabel.text = "Dialog: 标准对话框，支持模态和标准按钮"
                }
            }

            // 3. 自定义弹窗
            Button {
                text: "自定义弹窗"
                Layout.fillWidth: true
                onClicked: {
                    customPopup.open()
                    statusLabel.text = "自定义弹窗: 完全自定义样式和内容"
                }
            }

            Item { Layout.fillHeight: true }
        }

        // 右侧：窗口标志位
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: "窗口标志位 (Window Flags)"
                font.pointSize: 13
                font.bold: true
                color: "#333"
            }

            GridLayout {
                columns: 2
                columnSpacing: 10
                rowSpacing: 10
                Layout.fillWidth: true

                // Qt.Tool: 工具窗口
                Button {
                    text: "Qt.Tool"
                    Layout.fillWidth: true
                    onClicked: {
                        toolWindow.visible = true
                        statusLabel.text = "Qt.Tool: 工具窗口，窄标题栏，任务栏不显示"
                    }
                }

                // Qt.ToolTip: 提示窗口
                Button {
                    text: "Qt.ToolTip"
                    Layout.fillWidth: true
                    onClicked: {
                        tooltipWindow.visible = true
                        statusLabel.text = "Qt.ToolTip: 无边框浮动提示窗口"
                    }
                }

                // Qt.SplashScreen: 启动画面
                Button {
                    text: "Qt.SplashScreen"
                    Layout.fillWidth: true
                    onClicked: {
                        splashWindow.visible = true
                        statusLabel.text = "Qt.SplashScreen: 无边框启动画面"
                    }
                }

                // Qt.FramelessWindowHint: 无边框窗口
                Button {
                    text: "Qt.Frameless"
                    Layout.fillWidth: true
                    onClicked: {
                        framelessWindow.visible = true
                        statusLabel.text = "Qt.FramelessWindowHint: 无边框窗口，需自定义拖拽"
                    }
                }

                // Qt.WindowStaysOnTopHint: 置顶窗口
                Button {
                    text: "Qt.StayOnTop"
                    Layout.fillWidth: true
                    onClicked: {
                        topWindow.visible = true
                        statusLabel.text = "Qt.WindowStaysOnTopHint: 始终在最上层"
                    }
                }

                // Qt.Dialog: 对话框窗口
                Button {
                    text: "Qt.Dialog"
                    Layout.fillWidth: true
                    onClicked: {
                        dialogWindow.visible = true
                        statusLabel.text = "Qt.Dialog: 对话框样式窗口"
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }

    // ========== 弹窗示例 ==========

    // 1. 基础 Popup
    Popup {
        id: basicPopup
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        width: 250
        height: 120
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            color: "white"
            radius: 8
            border.color: "#ddd"
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

            Text {
                text: "这是一个 Popup"
                font.pointSize: 12
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "点击外部或按 Esc 关闭"
                font.pointSize: 10
                color: "#666"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // 2. Dialog 对话框
    Dialog {
        id: dialog
        title: "确认操作"
        modal: true
        anchors.centerIn: parent
        standardButtons: Dialog.Ok | Dialog.Cancel

        Label {
            text: "你确定要执行此操作吗？"
            font.pointSize: 12
        }

        onAccepted: statusLabel.text = "用户点击了 确定"
        onRejected: statusLabel.text = "用户点击了 取消"
    }

    // 3. 自定义弹窗
    Popup {
        id: customPopup
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        width: 300
        height: 200
        modal: true
        closePolicy: Popup.CloseOnEscape

        background: Rectangle {
            color: "#E91E63"
            radius: 12
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            Text {
                text: "自定义样式弹窗"
                font.pointSize: 14
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "通过 background 和 contentItem\n可以完全自定义弹窗样式"
                font.pointSize: 11
                color: "white"
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                text: "关闭"
                Layout.alignment: Qt.AlignHCenter
                onClicked: customPopup.close()
            }
        }
    }

    // ========== 窗口标志位示例 ==========

    // Qt.Tool: 工具窗口
    Window {
        id: toolWindow
        title: "Qt.Tool - 工具窗口"
        width: 300
        height: 200
        flags: Qt.Tool
        color: "#2196F3"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10

            Text {
                text: "Qt.Tool"
                font.pointSize: 14
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "窄标题栏工具窗口\n任务栏不显示独立图标\n适用于工具面板"
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
        title: "Qt.ToolTip"
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
            spacing: 10

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
            spacing: 10

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
            spacing: 10

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
            spacing: 10

            Text {
                text: "Qt.Dialog"
                font.pointSize: 13
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "对话框样式窗口\n可模态或非模态\n用于设置或确认操作"
                font.pointSize: 11
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
