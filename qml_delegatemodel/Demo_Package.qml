import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

FadeInAnimation {
    id: root

    ListModel {
        id: goodsModel
        ListElement { title: "苹果"; tone: "#E74C3C" }
        ListElement { title: "香蕉"; tone: "#F1C40F" }
        ListElement { title: "葡萄"; tone: "#8E44AD" }
        ListElement { title: "青柠"; tone: "#27AE60" }
        ListElement { title: "蓝莓"; tone: "#2980B9" }
        ListElement { title: "橙子"; tone: "#E67E22" }
    }

    DelegateModel {
        id: shareModel
        model: goodsModel

        delegate: Package {
            // 行式部件，供左侧 ListView 使用
            Rectangle {
                Package.name: "rowPart"
                width: listView.width
                height: 46
                color: "#FFFFFF"
                border.color: "#EAEAEA"
                border.width: 1

                Rectangle {
                    x: 12
                    anchors.verticalCenter: parent.verticalCenter
                    width: 12
                    height: 12
                    radius: 6
                    color: tone
                }

                Text {
                    x: 34
                    anchors.verticalCenter: parent.verticalCenter
                    text: title
                    color: "#333"
                    font.pointSize: 12
                }
            }

            // 卡片式部件，供右侧 GridView 使用
            Rectangle {
                Package.name: "cardPart"
                width: 96
                height: 96
                radius: 8
                color: "#FFFFFF"
                border.color: "#EAEAEA"
                border.width: 1

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 18
                    width: 28
                    height: 28
                    radius: 14
                    color: tone
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 58
                    text: title
                    color: "#333"
                    font.pointSize: 12
                    font.bold: true
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "包委托"
            description: "Package 把多个具名部件打包成一个委托，DelegateModel.parts 让不同视图各取所需，共享同一份数据。"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 16

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#FAFAFA"
                radius: 8
                border.color: "#e0e0e0"
                border.width: 1

                Text {
                    x: 12
                    y: 8
                    text: "parts.rowPart"
                    color: "#1296FF"
                    font.pointSize: 10
                }

                ListView {
                    id: listView
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.topMargin: 28
                    clip: true
                    model: shareModel.parts.rowPart
                }
            }

            Rectangle {
                Layout.preferredWidth: 340
                Layout.fillHeight: true
                color: "#FAFAFA"
                radius: 8
                border.color: "#e0e0e0"
                border.width: 1

                Text {
                    x: 12
                    y: 8
                    text: "parts.cardPart"
                    color: "#1296FF"
                    font.pointSize: 10
                }

                GridView {
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.topMargin: 28
                    clip: true
                    cellWidth: 100
                    cellHeight: 100
                    model: shareModel.parts.cardPart
                }
            }
        }
    }
}
