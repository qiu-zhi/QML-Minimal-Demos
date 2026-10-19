import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础网格"
            description: "GridView 由 model、delegate、cellWidth/cellHeight 组成，delegate 占满单元格后按网格依次排布。"
        }

        // 内容卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            GridView {
                id: grid
                anchors.fill: parent
                anchors.margins: 10
                clip: true

                cellWidth: 80
                cellHeight: 80

                model: ListModel {
                    ListElement { name: "音乐" }
                    ListElement { name: "电影" }
                    ListElement { name: "读书" }
                    ListElement { name: "旅行" }
                    ListElement { name: "摄影" }
                    ListElement { name: "编程" }
                    ListElement { name: "运动" }
                    ListElement { name: "美食" }
                    ListElement { name: "游戏" }
                    ListElement { name: "绘画" }
                    ListElement { name: "烘焙" }
                    ListElement { name: "露营" }
                }

                // delegate 占满整个单元格，内部卡片再留出间距
                delegate: Item {
                    required property int index
                    required property string name

                    width: grid.cellWidth
                    height: grid.cellHeight

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 4
                        radius: 8
                        color: "#FFFFFF"
                        border.color: "#e0e0e0"
                        border.width: 1

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: name
                                color: "#333"
                                font.pointSize: 12
                                font.bold: true
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: index + 1
                                color: "#999"
                                font.pointSize: 9
                            }
                        }
                    }
                }
            }
        }

        // 状态提示
        Text {
            Layout.fillWidth: true
            text: "共 " + grid.count + " 项"
            font.pointSize: 10
            color: "#666"
        }
    }
}