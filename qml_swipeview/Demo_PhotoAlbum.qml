import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    function nextPhoto() {
        if (swipeView.currentIndex >= swipeView.count - 1) {
            swipeView.currentIndex = 0
        } else {
            swipeView.currentIndex++;
        }
    }

    function prevPhoto() {
        if (swipeView.currentIndex <= 0) {
            swipeView.currentIndex = swipeView.count - 1
        } else {
            swipeView.currentIndex--;
        }
    }

    function playAlbum() {
        timer.running = !timer.running
    }

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: false
        onTriggered: { root.nextPhoto() }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "图片浏览器（简易版）"
            description: "SwipeView 加载图片，配合按钮实现上一张/下一张/自动播放"
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            Repeater {
                model: [
                    "qrc:/wallpaper/1.png",
                    "qrc:/wallpaper/2.png",
                    "qrc:/wallpaper/3.png",
                    "qrc:/wallpaper/4.png"
                ]
                Loader {
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: Image {
                        source: modelData
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            border.width: 1
            border.color: "#ccc"
            radius: 6

            Row {
                anchors.centerIn: parent
                spacing: 10

                RoundButton {
                    width: 40
                    height: 40
                    icon.source: "qrc:/images/left.svg"
                    icon.width: 40
                    icon.height: 40
                    ToolTip.visible: hovered
                    ToolTip.text: "上一个"
                    onClicked: root.prevPhoto()
                }

                // 播放/暂停共用一个按钮，图标随自动播放状态切换
                RoundButton {
                    width: 40
                    height: 40
                    icon.source: timer.running ? "qrc:/images/pause.svg" : "qrc:/images/play.svg"
                    icon.width: 40
                    icon.height: 40
                    ToolTip.visible: hovered
                    ToolTip.text: timer.running ? "暂停播放" : "自动播放"
                    onClicked: root.playAlbum()
                }

                RoundButton {
                    width: 40
                    height: 40
                    icon.source: "qrc:/images/right.svg"
                    icon.width: 40
                    icon.height: 40
                    ToolTip.visible: hovered
                    ToolTip.text: "下一个"
                    onClicked: root.nextPhoto()
                }
            }
        }
    }
}
