import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "事件传播与拦截"
            description: "按键事件从获得焦点的内层向外层逐级传播，设置 event.accepted = true 可阻止继续传播"
        }

        // 外层
        Rectangle {
            id: outer
            Layout.fillWidth: true
            Layout.preferredHeight: 220
            radius: 10
            color: "#FAFAFA"
            border.color: outer.hit ? "#E91E63" : "#ccc"
            border.width: 2

            property bool hit: false

            SequentialAnimation {
                id: flashOuter
                running: false
                ColorAnimation { target: outer; property: "color"; to: "#FFE0E0"; duration: 80 }
                ColorAnimation { target: outer; property: "color"; to: "#FAFAFA"; duration: 300 }
                ScriptAction { script: outer.hit = false }
            }

            Keys.onPressed: (event) => {
                hit = true; flashOuter.restart()
            }

            // 中层
            Rectangle {
                id: middle
                anchors.centerIn: parent
                width: 240; height: 130
                radius: 8
                color: "#FFF"
                border.color: middle.hit ? "#FF9800" : "#ccc"
                border.width: 2

                property bool hit: false

                SequentialAnimation {
                    id: flashMiddle
                    running: false
                    ColorAnimation { target: middle; property: "color"; to: "#FFF3E0"; duration: 80 }
                    ColorAnimation { target: middle; property: "color"; to: "#FFF"; duration: 300 }
                    ScriptAction { script: middle.hit = false }
                }

                Keys.onPressed: (event) => {
                    hit = true; flashMiddle.restart()
                }

                // 内层 —— 唯一可以获取焦点
                Rectangle {
                    id: inner
                    anchors.centerIn: parent
                    width: 160; height: 60
                    radius: 6
                    color: inner.activeFocus ? "#EAF4FF" : "#FFF"
                    border.color: inner.activeFocus ? "#1296FF" : "#ccc"
                    border.width: 2
                    focus: true

                    property bool hit: false

                    SequentialAnimation {
                        id: flashInner
                        running: false
                        ColorAnimation { target: inner; property: "color"; to: "#BBDEFB"; duration: 80 }
                        ColorAnimation { target: inner; property: "color"; to: inner.activeFocus ? "#EAF4FF" : "#FFF"; duration: 300 }
                        ScriptAction { script: inner.hit = false }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "点击这里，然后按任意键"
                        font.pointSize: 10
                        color: inner.activeFocus ? "#1296FF" : "#999"
                    }

                    MouseArea { anchors.fill: parent; onClicked: inner.forceActiveFocus() }

                    Keys.onPressed: (event) => {
                        hit = true; flashInner.restart()
                        if (interceptSwitch.checked)
                            event.accepted = true  // 拦截：阻止向外传播
                    }
                }
            }
        }

        // 拦截开关
        Switch {
            id: interceptSwitch
            Layout.alignment: Qt.AlignHCenter
            text: "内层拦截 (event.accepted = true)"
            checked: false
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: interceptSwitch.checked
                  ? "拦截开启：按键只触发内层（蓝色闪烁）"
                  : "拦截关闭：按键逐层传播（蓝→橙→红闪烁）"
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
