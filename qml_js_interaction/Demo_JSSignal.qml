import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "JS 函数作为信号槽"
            description: "定义一个 JavaScript 函数作为槽（Slot），通过 Connections 连接 Button 的 clicked 信号"
        }

        Text {
            text: "定义一个 JS 函数作为槽"
            font.pointSize: 12
        }

        Button {
            id: myButton
            text: "触发信号"
            font.pointSize: 12
        }

        Text {
            property int counter: 0

            id: myText
            text: "Counter: " + counter
            font.pointSize: 12

            // 定义一个 JS 函数作为槽（Slot）
            function handleButtonClick() {
                myText.counter++
            }

            Connections {
                target: myButton
                function onClicked() { myText.handleButtonClick() }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
