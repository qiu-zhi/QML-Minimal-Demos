import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    property string currentStatus: "等待信号..."
    property string lastMessage: ""

    // 获取c++ statusChanged 信号
    Connections {
        target: MyEmitter
        function onStatusChanged(status) {
            root.currentStatus = status
        }
    }

    // 获取c++ dataReceived 信号
    Connections {
        target: MyEmitter
        function onDataReceived(data) {
            root.lastMessage = JSON.stringify(data)
        }
    }

    Timer {
        id: statusTimer
        interval: 3000
        repeat: false

        onTriggered: {
            root.currentStatus = "等待信号..."
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "C++ 信号发送给 QML"
            description: "C++ 对象通过 context property 暴露给 QML，发射信号供 QML 接收"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#fff"
            border.color: "#ccc"
            border.width: 1
            radius: 6

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                Text {
                    text: "来自[C++] statusChanged 信号:"
                    font.pointSize: 11
                    font.bold: true
                    color: "#333"
                }

                Text {
                    text: root.currentStatus
                    font.pointSize: 11
                    color: "#3498db"
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            color: "#fff"
            border.color: "#ccc"
            border.width: 1
            radius: 6

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                Text {
                    text: "来自[C++] dataReceived 信号:"
                    font.pointSize: 11
                    font.bold: true
                    color: "#333"
                }

                Text {
                    text: root.lastMessage || "等待信号..."
                    font.pointSize: 11
                    color: "#3498db"
                    elide: Text.ElideRight
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignRight

            CustomButton {
                text: "开启定时器"
                Layout.preferredWidth: 100
                Layout.preferredHeight: 35
                onClicked: MyEmitter.startDemoSignals()
            }

            CustomButton {
                text: "关闭定时器"
                bgColor: "#e74c3c"
                Layout.preferredWidth: 100
                Layout.preferredHeight: 35
                onClicked: MyEmitter.stopDemoSignals()
            }
        }

        Item { Layout.fillHeight: true }
    }
}
