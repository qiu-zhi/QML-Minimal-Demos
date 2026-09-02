import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "动态添加/删除标签页"
            description: "通过 ListModel 动态增删 TabButton 与对应页面"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "添加标签"
                onClicked: {
                    var newIndex = tabModel.count + 1
                    tabModel.append({"tabName": "标签" + newIndex, "pageColor": Qt.rgba(Math.random(), Math.random(), Math.random(), 1)})
                }
            }

            Button {
                text: "删除当前"
                enabled: tabModel.count > 1
                onClicked: {
                    if (tabBar.currentIndex >= 0 && tabModel.count > 1) {
                        tabModel.remove(tabBar.currentIndex)
                    }
                }
            }

            Button {
                text: "清空全部"
                onClicked: {
                    tabModel.clear()
                    tabModel.append({"tabName": "标签1", "pageColor": "#3498db"})
                }
            }
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            clip: true

            Repeater {
                model: ListModel {
                    id: tabModel
                    ListElement { tabName: "标签1" }
                    ListElement { tabName: "标签2" }
                }
                delegate: TabButton {
                    text: tabName
                    width: implicitWidth + 10
                }
            }
        }

        StackLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: tabBar.currentIndex

            Repeater {
                model: tabModel
                delegate: Rectangle {
                    color: "#3498db"
                    Text {
                        anchors.centerIn: parent
                        text: tabName
                        color: "#fff"
                        font.pointSize: 18
                        font.bold: true
                    }
                }
            }
        }

        Text {
            text: "标签数量: " + tabModel.count
            font.pointSize: 11
            color: "#666"
        }
    }
}
