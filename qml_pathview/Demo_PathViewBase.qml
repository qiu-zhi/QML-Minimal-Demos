import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础直线路径"
            description: "PathView 由 model、delegate、path 三要素组成，delegate 沿 Path 的走向依次排布。"
        }

        // 内容卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            PathView {
                id: pathView
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                focus: true

                model: ListModel {
                    ListElement { name: "音乐"; cardColor: "#e74c3c" }
                    ListElement { name: "电影"; cardColor: "#e67e22" }
                    ListElement { name: "读书"; cardColor: "#f1c40f" }
                    ListElement { name: "旅行"; cardColor: "#2ecc71" }
                    ListElement { name: "摄影"; cardColor: "#1abc9c" }
                    ListElement { name: "编程"; cardColor: "#3498db" }
                    ListElement { name: "运动"; cardColor: "#9b59b6" }
                    ListElement { name: "美食"; cardColor: "#e84393" }
                }

                // 路径上同时出现的项数，路径总长按此数量等分，决定相邻项间距
                pathItemCount: 5
                snapMode: PathView.SnapToItem

                // 当前项固定在路径中点
                preferredHighlightBegin: 0.5
                preferredHighlightEnd: 0.5
                highlightRangeMode: PathView.StrictlyEnforceRange

                path: Path {
                    startX: 0
                    startY: pathView.height / 2
                    PathLine {
                        x: pathView.width
                        y: pathView.height / 2
                    }
                }

                delegate: Rectangle {
                    id: card
                    required property int index
                    required property string name
                    required property string cardColor

                    width: 90
                    height: 120
                    radius: 8
                    color: cardColor
                    // 附加属性 PathView.isCurrentItem 用来区分当前项
                    scale: PathView.isCurrentItem ? 1.1 : 0.85
                    opacity: PathView.isCurrentItem ? 1.0 : 0.55

                    Behavior on scale { NumberAnimation { duration: 150 } }
                    Behavior on opacity { NumberAnimation { duration: 150 } }

                    Column {
                        anchors.centerIn: parent
                        spacing: 4

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: card.name
                            color: "white"
                            font.pointSize: 14
                            font.bold: true
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "index " + card.index
                            color: "#FFFFFFCC"
                            font.pointSize: 9
                        }
                    }
                }

                Keys.onLeftPressed: pathView.decrementCurrentIndex()
                Keys.onRightPressed: pathView.incrementCurrentIndex()
            }
        }

        // 状态提示（窗口最底部的状态栏在 Main.qml 的 footer 里）
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Text {
                text: "当前项：index %1（%2 / 共 %3 项）"
                      .arg(pathView.currentIndex)
                      .arg(pathView.model.get(pathView.currentIndex).name)
                      .arg(pathView.count)
                font.pointSize: 10
                color: "#666"
            }

            Item { Layout.fillWidth: true }
        }
    }
}
