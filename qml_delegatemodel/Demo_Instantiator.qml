import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

FadeInAnimation {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "动态实例化"
            description: "Instantiator 按模型批量创建对象，model 可以直接是一个数字；把 active 关掉，创建出来的对象会被全部销毁。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            SpinBox {
                id: countBox
                from: 0
                to: 24
                value: 8
                font.pointSize: 10
            }

            Switch {
                id: activeSwitch
                text: "active"
                checked: true
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "count " + inst.count + " ｜ 首项 " + (inst.count > 0 ? inst.objectAt(0).objectName : "无")
                color: "#666"
                font.pointSize: 10
            }
        }

        Rectangle {
            id: card
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FAFAFA"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1
            clip: true

            Instantiator {
                id: inst
                model: countBox.value
                active: activeSwitch.checked

                delegate: Rectangle {
                    width: 48
                    height: 48
                    radius: 10
                    color: "#1296FF"
                    objectName: "方块 " + index

                    x: (index % 8) * 56 + 16
                    y: Math.floor(index / 8) * 56 + 16

                    Text {
                        anchors.centerIn: parent
                        text: index + 1
                        color: "white"
                        font.pointSize: 12
                        font.bold: true
                    }
                }

                // Instantiator 创建的对象不会自动进入可视化树，需要手动挂到容器上
                onObjectAdded: function (index, object) { object.parent = card }
            }
        }
    }
}
