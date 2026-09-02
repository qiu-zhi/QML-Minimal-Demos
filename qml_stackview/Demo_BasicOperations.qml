import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基本操作"
            description: "StackView 的 push / pop / replace 基本用法演示"
        }

        StackView {
            id: stack
            initialItem: mainView
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 15
            clip: true
        }

        Text {
            text: "StackView Depth: " + stack.depth
            color: "#333"
            font.pointSize: 11
        }
    }

    Component {
        id: mainView

        ColumnLayout {
            spacing: 10

            property color textColor: "#333"

            Button {
                text: "Push（叠加新页面）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                property var info: {"textColor":"green"}
                onClicked: stack.push(mainView, info)
            }

            Button {
                text: "Push（叠加新页面，无动画）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                property var info: {"textColor":"green"}
                onClicked: stack.push(mainView, info, StackView.Immediate)
            }

            Button {
                text: "Pop（回到上一页）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                enabled: stack.depth > 1
                onClicked: stack.pop()
            }

            // 栈长度不变，新的页面替换掉原有页面，退不回去
            Button {
                text: "Replace（替换当前页面）"
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                property var info: {"textColor":"red"}
                onClicked: stack.replace(mainView, info)
            }

            Item { Layout.fillHeight: true }
        }
    }
}
