import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.lottieqt

// 演示：帧级拖拽（gotoAndStop）+ 时长查询（getDuration）。
// 素材 document-ocr-scan.json：OCR 扫描动画，600×600，60fps，共 227 帧。
// 帧数足够多，逐帧拖动最能看出区别。
Rectangle {
    id: root
    color: "#FAFBFC"

    property bool playing: false
    property int shownFrame: 0

    readonly property bool ready: anim.status === LottieAnimation.Ready
    readonly property int frames: Math.max(0, anim.endFrame - anim.startFrame)

    // getDuration() 是普通函数调用，QML 捕获不到依赖关系，
    // 所以在表达式里显式读一下 endFrame / startFrame 作为「依赖锚点」，
    // 素材加载完成后这一行才会自动刷新。
    readonly property string durationText: {
        if (anim.endFrame <= anim.startFrame)
            return "—"
        return anim.getDuration(true) + " 帧 / "
                + anim.getDuration(false).toFixed(2) + " 秒"
    }

    function frameAt(v) {
        return Math.round(anim.startFrame + v * (anim.endFrame - anim.startFrame))
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 12

        Text {
            text: "拖拽控制"
            font.pixelSize: 18
            font.bold: true
            color: "#222"
        }
        Text {
            text: "拖动底部滑杆调用 gotoAndStop() 跳到任意一帧，可以直接读 getDuration() 拿到时长。素材为「文档扫描」，227 帧 @ 60fps。LottieAnimation 不暴露 currentFrame，所以播放中回读不到当前帧，帧号以拖拽后的值为准。"
            color: "#888"
            font.pixelSize: 12
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.minimumWidth: 0
            Layout.preferredWidth: 0
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 250
            radius: 10
            color: "#1E1F26"
            clip: true

            // 定尺容器：动画只在这个框里缩放显示（素材 600×600 会被强制写回控件尺寸）
            Item {
                id: animBox
                width: 210
                height: 210
                anchors.centerIn: parent

                LottieAnimation {
                    id: anim
                    source: "qrc:/lottie/document-ocr-scan.json"
                    autoPlay: true
                    loops: LottieAnimation.Infinite
                    quality: LottieAnimation.HighQuality
                    transformOrigin: Item.TopLeft
                    scale: (width > 0 && height > 0)
                           ? Math.min(animBox.width / width, animBox.height / height)
                           : 1

                    // autoPlay: true 时 loadFinished() 已经调过 start() 了，
                    // 这里不要再 gotoAndStop（会把刚启动的播放停掉），只同步镜像状态。
                    onStatusChanged: {
                        if (status === LottieAnimation.Ready) {
                            root.shownFrame = anim.startFrame
                            root.playing = true
                        }
                    }
                    onFinished: root.playing = false
                }
            }

            // 调试信息（左上角）
            Column {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 10
                spacing: 2
                Repeater {
                    model: [
                        "startFrame: " + anim.startFrame,
                        "endFrame:   " + anim.endFrame,
                        "时长:        " + root.durationText,
                        "素材:        " + anim.width + "×" + anim.height
                    ]
                    delegate: Text {
                        text: modelData
                        color: "#9AA3B2"
                        font.pixelSize: 11
                        font.family: "Consolas"
                    }
                }
            }

            // 当前帧（右上角，高亮）
            Rectangle {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 10
                width: frameLabel.implicitWidth + 20
                height: 24
                radius: 12
                color: "#2E3440"
                Text {
                    id: frameLabel
                    anchors.centerIn: parent
                    // LottieAnimation 没有暴露 currentFrame，播放中回读不到当前帧，
                    // 所以播放时只标个 playing，帧号以拖拽后的值为准。
                    text: root.playing ? "playing…" : ("frame " + root.shownFrame)
                    color: "#7FD1A6"
                    font.pixelSize: 11
                    font.family: "Consolas"
                }
            }
        }

        // 播放控制（播放 / 暂停合并为一个按钮）
        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            enabled: root.ready

            Button {
                text: root.playing ? "暂停" : "播放"
                implicitHeight: 32
                implicitWidth: 104
                onClicked: {
                    anim.togglePause()
                    root.playing = !root.playing
                }
            }
            Button {
                text: "回到起点"
                implicitHeight: 32
                onClicked: {
                    anim.pause()
                    root.playing = false
                    root.shownFrame = anim.startFrame
                    anim.gotoAndStop(anim.startFrame)
                    frameSlider.value = 0
                }
            }
            Item { Layout.fillWidth: true }
            Label {
                text: root.frames + " 帧"
                color: "#666"
                font.pixelSize: 11
            }
        }

        // 帧拖拽条：拖动时先暂停，避免定时器与滑杆互相打架
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            enabled: root.ready

            Label {
                text: "帧"
                color: "#888"
                font.pixelSize: 12
            }
            Slider {
                id: frameSlider
                Layout.fillWidth: true
                from: 0
                to: 1
                value: 0
                onMoved: {
                    if (root.playing) {
                        anim.pause()
                        root.playing = false
                    }
                    root.shownFrame = root.frameAt(value)
                    anim.gotoAndStop(root.shownFrame)
                }
            }
            Label {
                text: root.shownFrame
                color: "#333"
                font.pixelSize: 12
                font.bold: true
                Layout.preferredWidth: 44
                horizontalAlignment: Text.AlignRight
            }
        }
    }
}
