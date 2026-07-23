import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQml.WorkerScript

FadeInAnimation {
    property bool isProcessing: false
    property string resultText: ""

    // 工作线程脚本
    WorkerScript {
        id: myWorker
        source: "script.mjs"

        // 接收工作线程返回的消息
        onMessage: function (msgObj) {
            isProcessing = false;

            if (msgObj.error) {
                resultText = "错误: " + msgObj.error;
            } else {
                resultText = "计算结果: " + msgObj.result +
                        "\n耗时: " + msgObj.time + " ms" +
                        "\n任务ID: " + msgObj.taskId +
                        "\n原始消息: " + JSON.stringify(msgObj.originalMessage)
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "WorkerScript 工作线程"
            description: "通过 WorkerScript 在独立线程中执行耗时计算（如斐波那契数列），避免阻塞主 UI 线程"
        }

        Text {
            font.pointSize: 10
            text: "WorkerScript - 工作线程使用示例
                \n1.定义工作脚本文件（script.mjs）
                \n2.在QML中使用WorkerScript导入该文件
                \n3.通过WorkerScript.sendMessage()异步发送数据和指令
                \n4.在QML中通过WorkerScript.onMessage接收工作线程返回的结果"
        }

        Row {
            spacing: 15
            Button {
                id: btnCalc
                text: "计算斐波那契数列"
                font.pointSize: 12
                enabled: !isProcessing && myWorker.ready
                onClicked: {
                    isProcessing = true;
                    resultText = "计算斐波那契数列 ...";
                    myWorker.sendMessage({ 'taskId': 1001, 'n': textField.text, 'timestamp': Date.now() });
                }
            }

            TextField {
                id: textField
                text: "36"
                width: 60
                height: btnCalc.height
                placeholderText: "请输入数值"
                font.pointSize: 10

                // 背景框
               background: Rectangle {
                   border.color: "#c0c0c0"
                   border.width: 1
                   radius: 4
               }
            }
        }

        Text {
            text: resultText
            font.pointSize: 10
        }

        Item { Layout.fillHeight: true }
    }
}
