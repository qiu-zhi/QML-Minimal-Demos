import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

FadeInAnimation {
    id: root

    property bool firstHighlighted: false

    Component {
        id: itemComp

        Rectangle {
            property string label

            width: 320
            height: 44
            radius: 6
            color: "#F7FAFF"
            border.color: "#C9E2FF"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: parent.label
                color: "#333"
                font.pointSize: 12
            }
        }
    }

    ObjectModel {
        id: stackModel

        Rectangle {
            property string label: "条目 A"
            width: 320
            height: 44
            radius: 6
            color: "#F7FAFF"
            border.color: "#C9E2FF"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: parent.label
                color: "#333"
                font.pointSize: 12
            }
        }

        Rectangle {
            property string label: "条目 B"
            width: 320
            height: 44
            radius: 6
            color: "#F7FAFF"
            border.color: "#C9E2FF"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: parent.label
                color: "#333"
                font.pointSize: 12
            }
        }

        Rectangle {
            property string label: "条目 C"
            width: 320
            height: 44
            radius: 6
            color: "#F7FAFF"
            border.color: "#C9E2FF"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: parent.label
                color: "#333"
                font.pointSize: 12
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "对象模型"
            description: "ObjectModel 直接收纳已经写好的可视化对象当模型，视图不需要 delegate；append、remove、move 用来增删和调整顺序。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Button {
                text: "追加"
                font.pointSize: 10
                onClicked: stackModel.append(itemComp.createObject(null, { "label": "条目 " + (stackModel.count + 1) }))
            }

            Button {
                text: "删除首个"
                font.pointSize: 10
                enabled: stackModel.count > 0
                onClicked: stackModel.remove(0, 1)
            }

            Button {
                text: "末项前移"
                font.pointSize: 10
                enabled: stackModel.count > 1
                onClicked: stackModel.move(stackModel.count - 1, 0, 1)
            }

            Button {
                text: "改首项颜色"
                font.pointSize: 10
                enabled: stackModel.count > 0
                onClicked: {
                    root.firstHighlighted = !root.firstHighlighted
                    stackModel.get(0).color = root.firstHighlighted ? "#FFEFD5" : "#F7FAFF"
                }
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "共 " + stackModel.count + " 项"
                color: "#666"
                font.pointSize: 10
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FAFAFA"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                spacing: 6
                model: stackModel
            }
        }
    }
}
