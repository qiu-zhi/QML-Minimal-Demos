import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    property string respMsg: ""

    // 1. 初始化信号槽连接
    Component.onCompleted: {
        // 动态连接：从C++信号连接到当前页面定义槽函数
        if (MyEmitter) {
            MyEmitter.cppResponse.connect(mySlot)
        }
    }

    // 2. 触发C++信号，发送消息
    function callCppSignal(msg) {
        if (MyEmitter) {
            MyEmitter.cppResponse(msg)
        }
    }

    // 3. 接收信号，设置响应消息
    function mySlot(resp) {
        // respMsg 已绑定到Text组件中，赋值后会同步刷新显示
        respMsg = resp
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "JavaScript 动态连接"
            description: "通过 JavaScript 在运行时动态连接 C++ 信号与 QML 槽函数"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            color: "#fff"
            border.color: "#ccc"
            border.width: 1
            radius: 6

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                Text {
                    text: "触发C++信号，发送消息:"
                    font.pointSize: 11
                    color: "#333"
                    font.bold: true
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    CustomTextField {
                        id: msgInput
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        placeholderText: "输入要发送的消息..."
                    }

                    CustomButton {
                        text: "发送"
                        onClicked: {
                            if (msgInput.text.length > 0) {
                                callCppSignal(msgInput.text)
                                msgInput.text = ""
                            }
                        }
                    }
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
                    text: "QML端接收返回消息:"
                    font.pointSize: 11
                    color: "#333"
                    font.bold: true
                }

                Text {
                    Layout.fillWidth: true
                    text: root.respMsg || "等待C++响应..."
                    font.pointSize: 11
                    color: "#3498db"
                    elide: Text.ElideRight
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
