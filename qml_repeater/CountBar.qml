import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 五个 Demo 共用的「数量调节条」：增加 / 减少当前模型的数量，
// Repeater 的委托实例会随之自动增删。Demo 只需接上两个信号去改自己的 model
RowLayout {
    id: root

    signal increaseRequested()
    signal decreaseRequested()

    property bool canIncrease: true
    property bool canDecrease: true
    property string info: ""

    spacing: 10

    Button {
        text: "增加"
        enabled: root.canIncrease
        Layout.preferredHeight: 32
        onClicked: root.increaseRequested()
    }

    Button {
        text: "减少"
        enabled: root.canDecrease
        Layout.preferredHeight: 32
        onClicked: root.decreaseRequested()
    }

    Label {
        text: root.info
        color: "#888"
        font.pointSize: 10
    }

    Item { Layout.fillWidth: true }
}
