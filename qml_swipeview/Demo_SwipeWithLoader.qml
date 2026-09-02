import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "SwipeView 与 Loader"
            description: "使用 Loader 按需加载页面，配合日志区查看创建/销毁过程"
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            currentIndex: indicator.currentIndex
            Repeater {
                model: 5
                Loader {
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: CustomRect {
                        description: "This is CustomRect" + (index+1)
                        Component.onCompleted: logArea.message.append("created: CustomRect" + index)
                        Component.onDestruction: logArea.message.append("destroyed: CustomRect" + index)
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.minimumHeight: 100
            Layout.maximumHeight: 100
            Layout.margins: 10
            border.width: 1
            border.color: "#ccc"
            radius: 6

            LogArea {
                id: logArea
                anchors.fill: parent
            }
        }

        CustomPageIndicator {
            id: indicator
            Layout.alignment: Qt.AlignHCenter

            count: swipeView.count
            currentIndex: swipeView.currentIndex
            visible: count > 1
        }
    }
}
