import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        TitleSeparator {
            title: "多条件组合"
            description: "以 itemType 角色区分 header / content / footer 三类委托，content 内部再依据 importance 角色细化样式"
        }

        // 内容区：垂直方向填满剩余空间
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ListView {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8
                clip: true
                ScrollBar.vertical: ScrollBar {}

                model: ListModel {
                    ListElement { itemType: "header"; title: "项目列表"; subtitle: "包含多种类型的项目" }
                    ListElement { itemType: "content"; title: "内容项目 1"; description: "这是一个普通的内容项"; importance: "normal" }
                    ListElement { itemType: "content"; title: "重要项目"; description: "这是一个重要的内容项"; importance: "high" }
                    ListElement { itemType: "footer"; summary: "共计 3 个项目" }
                }

                delegate: DelegateChooser {
                    role: "itemType"

                    DelegateChoice {
                        roleValue: "header"
                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 62
                            color: "#4CAF50"
                            radius: 8

                            ColumnLayout {
                                anchors {
                                    fill: parent
                                    margins: 10
                                }
                                spacing: 3

                                Text {
                                    text: model.title
                                    color: "white"
                                    font {
                                        bold: true
                                        pixelSize: 17
                                    }
                                    Layout.fillWidth: true
                                }
                                Text {
                                    text: model.subtitle
                                    color: "white"
                                    font.pixelSize: 13
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }

                    DelegateChoice {
                        roleValue: "content"
                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 54
                            radius: 6

                            property bool isHighImportance: model.importance === "high"

                            color: isHighImportance ? "#FFF3E0" : "white"
                            border {
                                color: isHighImportance ? "#FF9800" : "#e0e0e0"
                                width: 1
                            }

                            ColumnLayout {
                                anchors {
                                    fill: parent
                                    margins: 8
                                }
                                spacing: 3

                                Text {
                                    text: model.title
                                    font {
                                        bold: isHighImportance
                                        pixelSize: 15
                                    }
                                    color: isHighImportance ? "#F57C00" : "black"
                                    Layout.fillWidth: true
                                }
                                Text {
                                    text: model.description
                                    font.pixelSize: 13
                                    color: "#666666"
                                    Layout.fillWidth: true
                                }
                            }
                        }
                    }

                    DelegateChoice {
                        roleValue: "footer"
                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 38
                            color: "#EEEEEE"
                            radius: 4

                            Text {
                                anchors.centerIn: parent
                                text: model.summary
                                font.pixelSize: 13
                                color: "#666666"
                            }
                        }
                    }
                }
            }
        }
    }
}
