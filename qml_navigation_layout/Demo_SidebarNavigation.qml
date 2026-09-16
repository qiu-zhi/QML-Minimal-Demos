import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    id: root

    QtObject {
        id: leftNav
        property int currentIndex: 0
        property var pages: [
            { name: "首页", color: "#3498db" },
            { name: "文件", color: "#9b59b6" },
            { name: "设置", color: "#e67e22" }
        ]
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "侧边导航栏"
            description: "左侧垂直导航栏，点击切换右侧内容区域"
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Rectangle {
                Layout.preferredWidth: 60
                Layout.fillHeight: true
                radius: 4
                color: "#f0f0f0"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 4

                    Repeater {
                        model: leftNav.pages

                        Rectangle {
                            id: navItem
                            required property int index
                            required property var modelData

                            Layout.fillWidth: true
                            Layout.preferredHeight: 36
                            radius: 4
                            color: leftNav.currentIndex === navItem.index ? navItem.modelData.color : "transparent"

                            Text {
                                anchors.centerIn: parent
                                text: navItem.modelData.name
                                font.pointSize: 10
                                color: leftNav.currentIndex === navItem.index ? "#fff" : "#333"
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: leftNav.currentIndex = navItem.index
                            }
                        }
                    }

                    // 撑开剩余空间，让导航项顶部对齐
                    Item {
                        Layout.fillHeight: true
                    }
                }
            }

            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: leftNav.currentIndex

                Repeater {
                    model: leftNav.pages

                    Rectangle {
                        id: contentPage
                        required property var modelData

                        color: contentPage.modelData.color
                        radius: 4

                        Text {
                            anchors.centerIn: parent
                            text: contentPage.modelData.name + "内容"
                            color: "#fff"
                            font.pointSize: 12
                            font.bold: true
                        }
                    }
                }
            }
        }
    }
}
