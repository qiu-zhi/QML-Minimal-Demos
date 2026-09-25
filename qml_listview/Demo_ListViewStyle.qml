import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Demo：ListView 样式（头像、分组、状态）
FadeInAnimation {

    ListModel {
        id: contactModel
        ListElement { name: "老王"; avatar: "qrc:/images/avatar1.png"; status: "在线" }
        ListElement { name: "张三"; avatar: ""; status: "在线" }
        ListElement { name: "李四"; avatar: ""; status: "在线" }
        ListElement { name: "联系人4"; avatar: "qrc:/images/avatar2.png"; status: "离线" }
        ListElement { name: "联系人5"; avatar: "qrc:/images/avatar3.png"; status: "忙碌" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ListView 样式"
            description: "联系人列表展示：头像占位、在线状态色、section 分组"
        }

        ListView {
            id: listView
            model: contactModel
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            header: Rectangle {
                width: listView.width
                height: 30
                color: "#2D82B5"
                Text {
                    anchors.centerIn: parent
                    text: "联系人列表"
                    font.pixelSize: 15
                    color: "white"
                }
            }

            delegate: Rectangle {
                width: listView.width
                height: 50
                color: ListView.isCurrentItem ? "#BCE6FF" : "white"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: parent.ListView.view.currentIndex = index
                }

                Row {
                    anchors.fill: parent
                    anchors.margins: 5
                    spacing: 10

                    Item {
                        width: 40
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            id: avatarImage
                            anchors.fill: parent
                            source: avatar
                            visible: status === Image.Ready
                            fillMode: Image.PreserveAspectCrop
                            Rectangle {
                                anchors.fill: parent
                                color: "#999999A0"
                                visible: model.status === "离线"
                            }
                        }

                        Rectangle {
                            visible: avatarImage.status !== Image.Ready
                            anchors.fill: parent
                            radius: 20
                            color: "#E0E0E0"
                            Text {
                                anchors.centerIn: parent
                                text: name[0]
                                font.pixelSize: 20
                            }
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 4

                        Text {
                            text: name
                            font.pixelSize: 14
                            font.bold: true
                        }

                        Text {
                            text: status
                            font.pixelSize: 12
                            color: {
                                if (status === "在线") return "#4CAF50"
                                if (status === "离线") return "#9E9E9E"
                                return "#F44336"
                            }
                        }
                    }
                }
            }

            section.property: "status"
            section.delegate: Rectangle {
                width: parent.width
                height: 26
                color: "#F5F5F5"
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    text: section
                    font.bold: true
                    font.pixelSize: 12
                    color: "#2D82B5"
                }
            }
        }
    }
}
