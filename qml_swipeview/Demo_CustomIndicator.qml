import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义指示器"
            description: "通过自定义 PageIndicator 的 delegate 实现带数字标签的指示器"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            SwipeView {
                id: swipeView
                anchors.fill: parent
                clip: true
                currentIndex: indicator.currentIndex

                Repeater {
                    model: 4
                    Loader {
                        active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                        sourceComponent: CustomRect {
                            description: "This is CustomRect" + (index+1)
                            Component.onCompleted: console.log("created:", index)
                            Component.onDestruction: console.log("destroyed:", index)
                        }
                    }
                }
            }

            PageIndicator {
                id: indicator
                interactive: true  // 启用点击跳转
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: 20
                }

                count: swipeView.count
                currentIndex: swipeView.currentIndex
                visible: count > 1
                spacing: 10

                delegate: Column {
                    spacing: 10

                    Rectangle {
                        width: 12
                        height: 12
                        radius: 6
                        color: index === swipeView.currentIndex ? "#21be2b" : "#e0e0e0"

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }

                    Text {
                        text: index + 1
                        color: "#21be2b"
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
