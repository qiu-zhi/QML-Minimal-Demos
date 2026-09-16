import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 640
    title: "QML Lottie 动画演示合集"
    color: "#FFF"

    ListModel {
        id: pageModel

        ListElement { name: "动画展示"; source: "Demo_Gallery.qml" }
        ListElement { name: "播放控制"; source: "Demo_BasicControls.qml" }
        ListElement { name: "拖拽控制"; source: "Demo_Scrubber.qml" }
        ListElement { name: "方向控制"; source: "Demo_DirectionLoop.qml" }
    }

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle { color: "#1296FF" }
        Label {
            text: root.title
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // 左侧导航：只留示例名一行
        ListView {
            id: navList
            Layout.preferredWidth: 170
            Layout.fillHeight: true
            clip: true
            currentIndex: 0

            model: pageModel

            delegate: Rectangle {
                width: parent ? parent.width : 170
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parent.ListView.view.currentIndex = index
                        pageLoader.source = model.source
                    }
                }

                Text {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: "#333"
                    font.pointSize: 11
                    font.bold: true
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: "#ddd"
        }

        // 右侧内容区
        Loader {
            id: pageLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: pageModel.get(0).source
        }
    }
}
