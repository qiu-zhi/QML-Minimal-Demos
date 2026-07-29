import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Dial 鼠标事件"
            description: "响应 onMoved 与 onPressedChanged 事件，捕捉用户交互状态"
        }

        Dial {
            id: control
            Layout.alignment: Qt.AlignHCenter
            width: 140
            height: 140
            from: 0
            to: 100
            value: 0

            onMoved: {
                result.text = "用户交互值变化:" + value.toFixed(2)
            }

            onPressedChanged: {
                result.text = pressed ? "按下" : "释放"
            }
        }

        Text {
            id: result
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 10
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
