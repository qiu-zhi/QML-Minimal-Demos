import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 信号接收端
Rectangle {
    id: root
    property string message: ""

    function slotReceiveMsg(msg) {
        root.message = "来自sender发送的数据: " + msg.toFixed(2)
    }

    Layout.fillWidth: true
    Layout.preferredHeight: 80
    color: "#fff"
    border.color: "#ccc"
    border.width: 1
    radius: 6

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Text {
            text: "[CustomReceiver.qml] 信号接收端:"
            color: "#333"
            font.pointSize: 11
            font.bold: true
        }

        Label {
            text: root.message || "等待信号发送 ..."
            font.pointSize: 11
            color: "#3498db"
            wrapMode: Text.WordWrap
        }
    }
}
