import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 顶部抽屉：消息通知列表（edge: Qt.TopEdge）
Drawer {
    id: root
    // 显式挂到窗口 overlay，抽屉的滑动边界就是窗口边缘
    parent: Overlay.overlay
    width: Overlay.overlay.width
    // 高度需容纳标题+分割线+5条消息（含间距），避免内容溢出面板底边
    height: Math.min(360, Overlay.overlay.height)
    edge: Qt.TopEdge
    modal: true

    background: Rectangle {
        color: "#e6e6e6"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 15

        Text {
            text: "消息通知"
            font.pointSize: 13
            font.bold: true
            color: "#333"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: "#ccc"
        }

        ListModel {
            id: msgModel
            ListElement { type: "opt_ok"; msg: "已保存，内容将在刷新后生效" }
            ListElement { type: "opt_ok"; msg: "密码已重置，请使用新密码进行登录" }
            ListElement { type: "opt_error"; msg: "网络开小差，请连接后重试" }
            ListElement { type: "sys"; msg: "新版本可用：V2.3.1，请立即更新体验最新功能" }
            ListElement { type: "sys"; msg: "维护通知：系统将于01-22 00:00-02:00升级，期间暂停服务" }
        }

        Repeater {
            model: msgModel

            Rectangle {
                id: msgItem
                required property string type
                required property string msg

                Layout.fillWidth: true
                Layout.preferredHeight: 40
                color: "#fff"
                radius: 6

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.close()
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 6

                    Rectangle {
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                        radius: 8
                        color: {
                            if (msgItem.type === "opt_ok") return "#2ecc71";
                            else if (msgItem.type === "opt_error") return "#e74c3c";
                            return "#3498db";
                        }
                    }

                    Text {
                        text: msgItem.msg
                        font.pointSize: 11
                        color: "#333"
                        Layout.fillWidth: true
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
