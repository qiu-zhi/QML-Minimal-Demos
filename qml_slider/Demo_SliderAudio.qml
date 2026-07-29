import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "音量控制"
            description: "Slider 在音量控制场景中的应用，带渐变进度条和图标"
        }

        // 深色面板，保留原 SliderAudio 的视觉风格
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1a1b26"
            radius: 6

            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                // 音量图标
                Image {
                    id: volumeIcon
                    source: control.value <= 0 ? "/icons/mute.png" : "/icons/volume.png"
                    width: 24
                    height: 24
                    Layout.alignment: Qt.AlignVCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (control.value > 0) {
                                control.lastValue = control.value
                                control.value = 0
                            } else {
                                control.value = control.lastValue || 50
                            }
                        }
                    }
                }

                // 音量滑块
                Slider {
                    id: control
                    Layout.fillWidth: true
                    padding: 0
                    property real lastValue: 50

                    from: 0
                    to: 100
                    value: 60
                    stepSize: 1
                    live: true

                    // 自定义背景
                    background: Rectangle {
                        x: control.leftPadding
                        y: control.topPadding + (control.availableHeight - height) / 2
                        width: control.availableWidth
                        height: 8
                        radius: 4
                        color: "#313244"

                        // 音量进度条
                        Rectangle {
                            width: control.visualPosition * parent.width
                            height: parent.height
                            radius: 4
                            gradient: Gradient {
                                orientation: Gradient.Horizontal
                                GradientStop { position: 0.0; color: "#89b4fa" }
                                GradientStop { position: 1.0; color: "#cba6f7" }
                            }
                        }
                    }

                    // 自定义手柄
                    handle: Rectangle {
                        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                        y: control.topPadding + control.availableHeight / 2 - height / 2
                        width: 16
                        height: 16
                        radius: 8
                        color: control.pressed ? "#cba6f7" : "#f9f9f9"
                        border.color: "#89b4fa"
                        border.width: 2

                        // 添加鼠标区域以确保可以拖动
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            drag {
                                target: parent
                                axis: Drag.XAxis
                                minimumX: 0
                                maximumX: control.availableWidth - parent.width
                            }
                            onPositionChanged: {
                                if (drag.active) {
                                    control.value = (parent.x / (control.availableWidth - parent.width)) * (control.to - control.from)
                                }
                            }
                        }
                    }
                }

                // 音量值显示
                Text {
                    text: Math.round(control.value) + "%"
                    color: "#cdd6f4"
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 40
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
