import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "事件传递"
            description: "演示 propagateComposedEvents 与 mouse.accepted 控制事件在重叠 MouseArea 间的传递"
        }

        Rectangle {
            id: parentBox
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "#EAF4FF"
            border.color: "#1296FF"
            border.width: 2

            property int parentCount: 0

            // 外层 MouseArea 事件日志
            Text {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 12
                text: "外层 MouseArea\n点击次数: " + parentBox.parentCount
                font.pointSize: 12
                color: "#1296FF"
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                id: parentMouse
                anchors.fill: parent
                onClicked: (mouse) => {
                    parentBox.parentCount++
                }
            }

            // 内层方块（z 更高，覆盖在父 MouseArea 之上）
            Rectangle {
                id: childBox
                width: 180
                height: 80
                radius: 8
                anchors.centerIn: parent
                color: childMouse.pressed ? "#FF6B6B" : (childMouse.containsMouse ? "#FF8787" : "#FFD4D4")
                border.color: "#FF6B6B"
                border.width: 2
                z: 1

                property int childCount: 0

                Text {
                    anchors.centerIn: parent
                    text: "内层 MouseArea\n点击次数: " + childBox.childCount
                    font.pointSize: 12
                    color: "#C0392B"
                    horizontalAlignment: Text.AlignHCenter
                }

                MouseArea {
                    id: childMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents: propagateSwitch.checked
                    onClicked: (mouse) => {
                        childBox.childCount++

                        // 若 propagate 为 true，放行事件给下层
                        if (propagateComposedEvents) {
                            mouse.accepted = false
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Switch {
                id: propagateSwitch
                text: "放行事件给下层"
                checked: false
            }

            Button {
                text: "重置计数"
                onClicked: {
                    parentBox.parentCount = 0
                    childBox.childCount = 0
                }
            }
        }
    }
}
