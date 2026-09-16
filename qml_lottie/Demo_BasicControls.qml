import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.lottieqt

// 演示：播放 / 暂停（合并成一个按钮，内部走 togglePause()）、停止、从头播放。
// 素材 success.json：带对勾的圆环，600×600，ip = 25 / op = 69。
// 注意 ip 不为 0 —— 这是最容易踩的坑，见下面 onStatusChanged 的说明。
Rectangle {
    id: root
    color: "#FAFBFC"

    property int _controlHeight: 34

    // LottieAnimation 没有 playing 属性，无法从 QML 读回播放状态，
    // 所以按钮文案（播放 / 暂停）需要自己维护一个镜像状态。
    // 本示例 autoPlay: true，进入即为播放中。
    property bool playing: true

    readonly property bool ready: anim.status === LottieAnimation.Ready

    function statusText() {
        // LottieAnimation.Status: Null / Loading / Ready / Error
        switch (anim.status) {
        case LottieAnimation.Null: return "Null（未加载）"
        case LottieAnimation.Loading: return "Loading（加载中…）"
        case LottieAnimation.Ready: return "Ready（已就绪）"
        case LottieAnimation.Error: return "Error（加载失败）"
        }
        return "?"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 14

        Text {
            text: "播放控制"
            font.pixelSize: 18
            font.bold: true
            color: "#222"
        }
        Text {
            text: "一进入本示例即自动播放。播放与暂停合并为一个按钮（内部调用 togglePause()），另配停止、从头播放。素材为「对勾圆环」，loops = Infinite。"
            color: "#888"
            font.pixelSize: 12
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.minimumWidth: 0
            Layout.preferredWidth: 0
        }

        // 动画展示区
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 260
            radius: 10
            color: "#FFFFFF"
            border.color: "#E3E6ED"
            border.width: 1

            // LottieAnimation 在素材解析完成后会调用 setWidth()/setHeight() 把自身尺寸
            // 强制改写成素材固有尺寸（success.json 是 600×600），所以直接给它写
            // width/height 是无效的。正确做法：外面套一个固定尺寸的 Item 决定「显示多大」，
            // 再用 Item::scale 把 600×600 的内容等比缩进去。
            Item {
                id: animBox
                width: 230
                height: 230
                anchors.centerIn: parent

                LottieAnimation {
                    id: anim
                    source: "qrc:/lottie/success.json"
                    autoPlay: true
                    loops: LottieAnimation.Infinite
                    quality: LottieAnimation.HighQuality

                    // 不要设置 width/height：加载后会被覆盖成 600×600。
                    // transformOrigin 放左上角，缩放后才正好对齐外层容器。
                    transformOrigin: Item.TopLeft
                    scale: (width > 0 && height > 0)
                           ? Math.min(animBox.width / width, animBox.height / height)
                           : 1

                    // 素材的 ip = 25，而播放头初值是 0，落在 [startFrame, endFrame] 之外。
                    // 若用 autoPlay: false，初次 play() 只会把定时器空转起来 ——
                    // renderNextFrame() 两个分支都不成立，一帧都不会推进（表现为「点了播放没反应」）；
                    // 又因为帧号的推进写在 paint() 里，没有 update() 就永远不会被触发，状态卡死。
                    // 「停止」之所以能救回来，是因为 reset() 会把播放头直接设成 startFrame 再补一次重绘。
                    //
                    // 本示例用 autoPlay: true 走另一条路：loadFinished() 里会自动 start()，
                    // 而 start() 内部的 reset() 已经把播放头摆到 startFrame 了。
                    // ⚠️ 此时【不能】再调 gotoAndStop()，否则会把刚启动的播放停掉。
                    onStatusChanged: {
                        if (status === LottieAnimation.Ready)
                            root.playing = true
                    }

                    // loops 有限时播完会自动停表，镜像状态要跟上（本示例是 Infinite，走不到）
                    onFinished: root.playing = false
                }
            }

            Text {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: "状态：" + root.statusText()
                color: anim.status === LottieAnimation.Error ? "#E5484D" : "#4A5568"
                font.pixelSize: 12
            }

            // 素材信息角标：直观看到「素材固有尺寸」与「显示尺寸」是两回事
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 12
                width: infoText.implicitWidth + 20
                height: 24
                radius: 12
                color: "#F1F3F8"
                Text {
                    id: infoText
                    anchors.centerIn: parent
                    text: "素材 " + anim.width + "×" + anim.height
                          + "  →  显示 " + Math.round(anim.width * anim.scale) + "×"
                          + Math.round(anim.height * anim.scale)
                    color: "#5A6472"
                    font.pixelSize: 11
                }
            }
        }

        // 控制条（未加载完成前整排禁用，避免在 Loading 阶段无效点击）
        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            enabled: root.ready

            Button {
                text: root.playing ? "暂停" : "播放"
                Layout.preferredHeight: root._controlHeight
                Layout.preferredWidth: 110
                onClicked: {
                    anim.togglePause()
                    root.playing = !root.playing
                }
            }
            Button {
                text: "停止"
                Layout.preferredHeight: root._controlHeight
                onClicked: {
                    anim.stop()          // 停止并回到 startFrame
                    root.playing = false
                }
            }
            Button {
                text: "从头播放"
                Layout.preferredHeight: root._controlHeight
                onClicked: {
                    anim.gotoAndPlay(anim.startFrame)
                    root.playing = true
                }
            }
            Item { Layout.fillWidth: true }
            Label {
                text: root.playing ? "播放中" : "已暂停"
                color: root.playing ? "#2E7D4F" : "#888"
                font.pixelSize: 12
            }
        }
    }
}
