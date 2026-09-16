import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    id: root

    QtObject {
        id: bottomNav
        property int currentIndex: 0
        property var pages: [
            { icon: "qrc:/icons/home.svg", label: "首页", color: "#3498db" },
            { icon: "qrc:/icons/search.svg", label: "发现", color: "#e74c3c" },
            { icon: "qrc:/icons/message.svg", label: "消息", color: "#f39c12" },
            { icon: "qrc:/icons/user.svg", label: "我的", color: "#9b59b6" }
        ]
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "底部导航栏"
            description: "底部图标导航栏，类似移动端 App 的 Tab 切换"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 4

            StackLayout {
                anchors.fill: parent
                currentIndex: bottomNav.currentIndex

                Repeater {
                    model: bottomNav.pages

                    Rectangle {
                        id: tabPage
                        required property var modelData

                        color: tabPage.modelData.color

                        Text {
                            anchors.centerIn: parent
                            text: tabPage.modelData.label
                            color: "#fff"
                            font.pointSize: 14
                            font.bold: true
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 44
            color: "#f8f9fa"
            radius: 4
            border.color: "#dee2e6"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 4

                Repeater {
                    model: bottomNav.pages

                    Rectangle {
                        id: tabButton
                        required property int index
                        required property var modelData

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: bottomNav.currentIndex === tabButton.index ? "#e3f2fd" : "transparent"
                        radius: 4

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 2

                            Image {
                                source: tabButton.modelData.icon
                                sourceSize.width: 18
                                sourceSize.height: 18
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: tabButton.modelData.label
                                font.pointSize: 8
                                color: bottomNav.currentIndex === tabButton.index ? tabButton.modelData.color : "#666"
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: bottomNav.currentIndex = tabButton.index
                        }
                    }
                }
            }
        }
    }
}
