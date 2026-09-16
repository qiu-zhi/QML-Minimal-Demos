import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.lottieqt

// 演示：direction（正向 / 反向）与 loops（循环次数）。
// 素材 delete-bin.json：删除文件，1200×1200，30fps，60 帧。
// 正向是「文件被丢进垃圾桶」，反向就是「文件从垃圾桶里飞回来」，方向感很清楚。
Rectangle {
    id: root
    color: "#FAFBFC"

    property bool playing: false
    property int selectedLoops: -1          // -1 表示永远循环
    // 有限循环跑完后播放头会停在 [startFrame, endFrame] 之外，标记一下便于重新起步
    property bool everFinished: false

    readonly property bool ready: anim.status === LottieAnimation.Ready

    function loopLabel() {
        return selectedLoops === -1 ? "无限" : (selectedLoops + " 次")
    }

    // 当前方向对应的起点：正向从头，反向从尾
    function startFrameOf() {
        return anim.direction === LottieAnimation.Forward ? anim.startFrame : anim.endFrame
    }

    // 从方向对应的一端重新起步。gotoAndPlay() 内部会把循环计数器清零。
    function restart() {
        anim.gotoAndPlay(startFrameOf())
        root.everFinished = false
        root.playing = true
    }

    // 播放 / 暂停合并成一个按钮
    function togglePlay() {
        if (root.playing) {
            anim.pause()
            root.playing = false
            return
        }
        // ⚠️ 跑完过之后不能再用 play()：播放头在区间外，play() 只会立刻再报一次 finished
        if (root.everFinished) {
            root.restart()
        } else {
            anim.play()
            root.playing = true
        }
    }

    // ⚠️ 改 loops 必须让 qtlottie 内部的 m_currentLoop 归零，否则新的循环次数不生效。
    // 那个计数器只在 reset() / gotoAndPlay() / setDirection() 里清零，
    // gotoAndStop() 和 play() 都不清 —— 残留计数会让 (loops - m_currentLoop) 永远 != 0，
    // 于是动画一直循环下去，选了「1 次」也停不下来。stop() 内部就是 reset()，所以用它。
    function setLoops(v) {
        root.selectedLoops = v
        anim.loops = v
        anim.stop()             // 停表 + reset()：计数器归零，播放头回到该方向的起点
        root.everFinished = false
        root.playing = false
    }

    // 切方向：setDirection() 自己会清零计数器，再用 gotoAndPlay 从该方向的起点起跑
    function setDirection(d) {
        anim.direction = d
        root.restart()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 12

        Text {
            text: "方向控制"
            font.pixelSize: 18
            font.bold: true
            color: "#222"
        }
        Text {
            text: "direction 让动画正向 / 反向播放，loops 控制循环次数。素材为「删除文件」，倒放会看到文件从垃圾桶里飞回来。"
            color: "#888"
            font.pixelSize: 12
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.minimumWidth: 0
            Layout.preferredWidth: 0
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 240
            radius: 10
            color: "#FFFFFF"
            border.color: "#E3E6ED"
            border.width: 1

            // 定尺容器：素材 1200×1200，控件尺寸会被强制写成素材尺寸，只能靠 scale 缩进这个框
            Item {
                id: animBox
                width: 200
                height: 200
                anchors.centerIn: parent

                LottieAnimation {
                    id: anim
                    source: "qrc:/lottie/delete-bin.json"
                    autoPlay: false
                    loops: root.selectedLoops
                    direction: LottieAnimation.Forward
                    quality: LottieAnimation.MediumQuality
                    transformOrigin: Item.TopLeft
                    scale: (width > 0 && height > 0)
                           ? Math.min(animBox.width / width, animBox.height / height)
                           : 1

                    onStatusChanged: {
                        if (status === LottieAnimation.Ready) {
                            gotoAndStop(startFrame)
                            root.playing = false
                            root.everFinished = false
                        }
                    }

                    onFinished: {
                        root.playing = false        // 有限循环播完会自己停表
                        root.everFinished = true
                    }
                }
            }

            // 当前状态角标
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 12
                width: 110
                height: 26
                radius: 13
                color: "#F1F3F8"
                Text {
                    anchors.centerIn: parent
                    text: (anim.direction === LottieAnimation.Forward ? "正向" : "反向")
                          + " · " + root.loopLabel()
                    color: "#5A6472"
                    font.pixelSize: 11
                }
            }
        }

        // 播放控制
        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            enabled: root.ready

            Button {
                text: root.playing ? "暂停" : "播放"
                implicitHeight: 32
                implicitWidth: 88
                onClicked: root.togglePlay()
            }
            Button {
                text: "重播"
                implicitHeight: 32
                implicitWidth: 72
                onClicked: root.restart()
            }
            Item { Layout.fillWidth: true }
            Label {
                text: "第 " + anim.startFrame + " ~ " + anim.endFrame + " 帧"
                color: "#666"
                font.pixelSize: 11
            }
        }

        // 方向控制（正向 / 反向 互斥选中）
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            enabled: root.ready

            Label { text: "方向"; color: "#555"; font.bold: true }

            ButtonGroup {
                id: dirGroup
                exclusive: true
            }
            Button {
                text: "正向"
                implicitHeight: 32
                implicitWidth: 76
                checkable: true
                checked: anim.direction === LottieAnimation.Forward
                ButtonGroup.group: dirGroup
                onClicked: root.setDirection(LottieAnimation.Forward)
            }
            Button {
                text: "反向"
                implicitHeight: 32
                implicitWidth: 76
                checkable: true
                checked: anim.direction === LottieAnimation.Reverse
                ButtonGroup.group: dirGroup
                onClicked: root.setDirection(LottieAnimation.Reverse)
            }
            Item { Layout.fillWidth: true }
        }

        // 循环次数控制（互斥选中）
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            enabled: root.ready

            Label { text: "循环"; color: "#555"; font.bold: true }

            ButtonGroup {
                id: loopGroup
                exclusive: true
            }
            Repeater {
                model: [
                    { v: 1, t: "1 次" },
                    { v: 3, t: "3 次" },
                    { v: -1, t: "无限" }
                ]
                delegate: Button {
                    text: modelData.t
                    implicitHeight: 32
                    implicitWidth: 76
                    checkable: true
                    checked: root.selectedLoops === modelData.v
                    ButtonGroup.group: loopGroup
                    onClicked: root.setLoops(modelData.v)
                }
            }
            Item { Layout.fillWidth: true }
        }
    }
}
