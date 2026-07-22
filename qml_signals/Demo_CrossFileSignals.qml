import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "跨文件信号通信"
            description: "使用 Component.onCompleted 动态连接不同 QML 组件之间的信号与槽"
        }

        // 信号发送端
        CustomSender {
            id: sender
        }

        // 信号接收端
        CustomReceiver {
            id: receiver
        }

        // 初始化信号槽连接
        Component.onCompleted: {
           sender.sendValue.connect(receiver.slotReceiveMsg)
        }

        Item { Layout.fillHeight: true }
    }
}
