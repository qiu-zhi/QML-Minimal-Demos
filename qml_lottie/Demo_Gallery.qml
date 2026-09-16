import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.lottieqt

// 演示：同一界面同时跑多个 LottieAnimation（4 个素材各一个），
// 既能统一控制，也能点单张卡片单独暂停 —— 每个动画是完全独立的状态机。
Rectangle {
    id: root
    color: "#FAFBFC"

    property bool allPlaying: true

    property var cards: [
        { name: "对勾圆环", src: "qrc:/lottie/success.json" },
        { name: "文档扫描", src: "qrc:/lottie/document-ocr-scan.json" },
        { name: "沙漏加载", src: "qrc:/lottie/loading-sand-clock_qt.json" },
        { name: "删除文件", src: "qrc:/lottie/delete-bin.json" }
    ]

    // 统一控制所有卡片：卡片本身对外暴露 setPlaying()
    // 注意 Grid 是 positioner，既没有 count 也没有 itemAt()，
    // 要通过 Repeater 来索引子项（Repeater.count / Repeater.itemAt(i) 才有）。
    function setAll(on) {
        allPlaying = on
        for (var i = 0; i < cardRepeater.count; ++i) {
            var c = cardRepeater.itemAt(i)
            if (c)
                c.setPlaying(on)
        }
    }

    // 单卡片被点了之后，把「全部播放 / 全部暂停」的文案同步过来
    function syncAllPlaying() {
        for (var i = 0; i < cardRepeater.count; ++i) {
            var c = cardRepeater.itemAt(i)
            if (c && c.playing) {
                allPlaying = true
                return
            }
        }
        allPlaying = false
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 12

        Text {
            text: "动画展示"
            font.pixelSize: 18
            font.bold: true
            color: "#222"
        }
        Text {
            text: "4 个素材各起一个 LottieAnimation，同时独立播放。可用上方按钮统一播放 / 暂停，也可以直接点某张卡片单独控制它。"
            color: "#888"
            font.pixelSize: 12
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.minimumWidth: 0
            Layout.preferredWidth: 0
        }

        // 统一控制
        RowLayout {
            Layout.fillWidth: true
            spacing: 10
            Button {
                text: root.allPlaying ? "全部暂停" : "全部播放"
                implicitHeight: 32
                implicitWidth: 116
                onClicked: root.setAll(!root.allPlaying)
            }
            Button {
                text: "全部重播"
                implicitHeight: 32
                onClicked: {
                    root.setAll(true)
                    for (var i = 0; i < cardRepeater.count; ++i) {
                        var c = cardRepeater.itemAt(i)
                        if (!c)
                            continue
                        var a = c.childAnim()
                        a.gotoAndPlay(a.startFrame)
                    }
                }
            }
            Item { Layout.fillWidth: true }
            Label {
                text: "点卡片可单独暂停某一路"
                color: "#999"
                font.pixelSize: 11
            }
        }

        Grid {
            id: grid
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 2
            columnSpacing: 14
            rowSpacing: 14

            Repeater {
                id: cardRepeater
                model: root.cards

                delegate: Rectangle {
                    id: card
                    property bool playing: true

                    width: (grid.width - grid.columnSpacing) / 2
                    height: (grid.height - grid.rowSpacing) / 2
                    radius: 10
                    color: "#FFFFFF"
                    border.color: card.playing ? "#C9D4E8" : "#E3E6ED"
                    border.width: 1
                    clip: true

                    function setPlaying(on) {
                        playing = on
                        if (on)
                            anim.play()
                        else
                            anim.pause()
                    }
                    // 供控件外部统一驱动的出口
                    function childAnim() { return anim }

                    // 定尺容器：控件自己的 width/height 会被素材尺寸覆盖，缩放只能靠 scale
                    Item {
                        id: animBox
                        readonly property real side: Math.max(50, Math.min(card.width - 44,
                                                                          card.height - 30 - 30))
                        width: side
                        height: side
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 14

                        LottieAnimation {
                            id: anim
                            source: modelData.src
                            autoPlay: true
                            loops: LottieAnimation.Infinite
                            quality: LottieAnimation.MediumQuality
                            transformOrigin: Item.TopLeft
                            scale: (width > 0 && height > 0)
                                   ? Math.min(animBox.width / width, animBox.height / height)
                                   : 1
                        }
                    }

                    // 底部信息条
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 30
                        color: "#F4F6FA"
                        border.color: "#E3E6ED"
                        border.width: 1

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.name
                            color: "#555"
                            font.pixelSize: 12
                            font.bold: true
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            text: "素材 " + anim.width + "×" + anim.height
                            color: "#98A2B3"
                            font.pixelSize: 10
                        }
                    }

                    // 播放状态角标
                    Rectangle {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 8
                        width: stateText.implicitWidth + 16
                        height: 20
                        radius: 10
                        color: card.playing ? "#E6F6EC" : "#F0F0F0"
                        Text {
                            id: stateText
                            anchors.centerIn: parent
                            text: card.playing ? "播放中" : "已暂停"
                            color: card.playing ? "#2E7D4F" : "#999"
                            font.pixelSize: 10
                        }
                    }

                    // 点卡片单独开关这一路动画
                    MouseArea {
                        anchors.fill: parent
                        anchors.bottomMargin: 30
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            card.setPlaying(!card.playing)
                            root.syncAllPlaying()
                        }
                    }
                }
            }
        }
    }
}
