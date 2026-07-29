import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    property bool isPlaying: false
    property int currentTime: videoSlider.value

    // 时间格式化函数
    function formatTime(seconds) {
        var mins = Math.floor(seconds / 60)
        var secs = Math.floor(seconds % 60)
        return (mins < 10 ? "0" : "") + mins + ":" + (secs < 10 ? "0" : "") + secs
    }

    // 控制按钮数据模型
    ListModel {
        id: controlButtons
        ListElement {
            icon: "/icons/rewind.svg"
            size: 36
            action: "rewind"
        }
        ListElement {
            icon: "/icons/play.svg"
            size: 36
            action: "play"
        }
        ListElement {
            icon: "/icons/forward.svg"
            size: 36
            action: "forward"
        }
    }

    // 播放定时器
    Timer {
        id: playbackTimer
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if (videoSlider.value < videoSlider.to) {
                videoSlider.value += 1
            } else {
                running = false
                isPlaying = false
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "视频进度条"
            description: "Slider 在视频播放进度控制中的应用，含缓冲进度和播放控制"
        }

        // 深色面板，保留原 SliderVideo 的视觉风格
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1a1b26"
            radius: 6

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 15

                // 时间显示
                RowLayout {
                    Layout.fillWidth: true
                    Text {
                        text: formatTime(currentTime)
                        color: "#7aa2f7"
                        font.pixelSize: 14
                    }
                    Item { Layout.fillWidth: true }
                    Text {
                        text: formatTime(videoSlider.to)
                        color: "#7aa2f7"
                        font.pixelSize: 14
                    }
                }

                // 视频进度条
                Slider {
                    id: videoSlider
                    Layout.fillWidth: true
                    padding: 0
                    from: 0
                    to: 600  // 10分钟视频
                    value: 245
                    stepSize: 1
                    live: true

                    onValueChanged: {
                        currentTime = value
                    }

                    // 自定义背景
                    background: Rectangle {
                        x: videoSlider.leftPadding
                        y: videoSlider.topPadding + (videoSlider.availableHeight - height) / 2
                        width: videoSlider.availableWidth
                        height: 6
                        radius: 3
                        color: "#313244"

                        // 缓冲进度
                        Rectangle {
                            width: parent.width * 0.7
                            height: parent.height
                            radius: 3
                            color: "#565f89"
                        }

                        // 播放进度
                        Rectangle {
                            width: videoSlider.visualPosition * parent.width
                            height: parent.height
                            radius: 3
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop { position: 0.0; color: "#7aa2f7" }
                                GradientStop { position: 1.0; color: "#bb9af7" }
                            }
                        }

                        // 点击背景更新进度
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                videoSlider.value = (mouseX / parent.width) * (videoSlider.to - videoSlider.from) + videoSlider.from
                            }
                        }
                    }

                    // 自定义手柄
                    handle: Rectangle {
                        x: videoSlider.leftPadding + videoSlider.visualPosition * (videoSlider.availableWidth - width)
                        y: videoSlider.topPadding + videoSlider.availableHeight / 2 - height / 2
                        width: 12
                        height: 12
                        radius: 6
                        color: videoSlider.pressed ? "#bb9af7" : "#c0caf5"
                        border.color: "#7aa2f7"
                        border.width: 2

                        // 手柄拖动区域
                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -10  // 扩大点击区域
                            drag {
                                target: parent
                                axis: Drag.XAxis
                                minimumX: 0
                                maximumX: videoSlider.availableWidth - parent.width
                            }
                            onPositionChanged: {
                                if (drag.active) {
                                    videoSlider.value = (parent.x / (videoSlider.availableWidth - parent.width)) * (videoSlider.to - videoSlider.from) + videoSlider.from
                                }
                            }
                        }
                    }
                }

                // 控制按钮
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 20

                    Repeater {
                        model: controlButtons
                        delegate: Rectangle {
                            width: model.size
                            height: model.size
                            radius: model.size / 2
                            color: mouseArea.pressed ? "#3d59a1" : "transparent"
                            border.color: "#7aa2f7"
                            border.width: 1

                            Image {
                                anchors.centerIn: parent
                                width: model.size * 0.6
                                height: model.size * 0.6
                                source: model.action === "play" ?
                                            (isPlaying ? "/icons/pause.svg" : "/icons/play.svg") :
                                            model.icon
                            }

                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                onClicked: {
                                    switch(model.action) {
                                    case "rewind":
                                        videoSlider.value = Math.max(videoSlider.from, videoSlider.value - 10)
                                        break
                                    case "play":
                                        isPlaying = !isPlaying
                                        playbackTimer.running = isPlaying
                                        break
                                    case "forward":
                                        videoSlider.value = Math.min(videoSlider.to, videoSlider.value + 10)
                                        break
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
