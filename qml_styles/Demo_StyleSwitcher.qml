import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qml_styles

FadeInAnimation {
    id: root

    readonly property var styleNotes: ({
        "Basic": "轻量、性能最好，控件最朴素，适合完全自绘",
        "Fusion": "跨平台桌面风格，跟随系统自动切换明暗，Linux 默认样式",
        "Material": "Google Material Design，带明暗主题和主色、强调色",
        "Universal": "微软通用设计规范，跨设备一致，带明暗主题和强调色",
        "Imagine": "基于图片素材，换一套图片就能整体换装",
        "Windows": "Windows 原生观感，Windows 平台的默认样式"
    })

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "样式切换"
            description: "样式在 QML 加载前就定死了，运行中换不了。点下面的卡片会用新样式重启当前程序。"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            radius: 8
            color: "#F5F7FA"
            border.color: "#e0e0e0"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                Text {
                    text: "当前样式"
                    font.pointSize: 10
                    color: "#666"
                }

                Text {
                    text: StyleHelper.currentStyle.length > 0
                          ? StyleHelper.currentStyle : "平台默认"
                    font.pointSize: 14
                    font.bold: true
                    color: "#1296FF"
                }

                // 撑满剩余宽度，否则 RowLayout 会把两个文本均匀摊开
                Item { Layout.fillWidth: true }
            }
        }

        GridLayout {
            Layout.fillWidth: true
            columns: 3
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: StyleHelper.styles

                delegate: Rectangle {
                    id: card
                    required property string modelData

                    Layout.fillWidth: true
                    Layout.preferredHeight: 90
                    radius: 8
                    color: hover.hovered ? "#F0F7FF" : "#FFFFFF"
                    border.color: card.modelData === StyleHelper.currentStyle ? "#1296FF" : "#e0e0e0"
                    border.width: card.modelData === StyleHelper.currentStyle ? 2 : 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 6

                        RowLayout {
                            spacing: 6

                            Text {
                                text: card.modelData
                                font.pointSize: 13
                                font.bold: true
                                color: "#333"
                            }

                            Rectangle {
                                visible: card.modelData === StyleHelper.currentStyle
                                radius: 3
                                implicitWidth: currentTag.implicitWidth + 10
                                implicitHeight: currentTag.implicitHeight + 4
                                color: "#1296FF"

                                Text {
                                    id: currentTag
                                    anchors.centerIn: parent
                                    text: "当前"
                                    color: "white"
                                    font.pointSize: 9
                                }
                            }

                            Item { Layout.fillWidth: true }
                        }

                        Text {
                            Layout.fillWidth: true
                            text: root.styleNotes[card.modelData] ?? ""
                            font.pointSize: 10
                            color: "#888"
                            wrapMode: Text.Wrap
                        }

                        Item { Layout.fillHeight: true }
                    }

                    HoverHandler {
                        id: hover
                        cursorShape: Qt.PointingHandCursor
                    }

                    TapHandler {
                        onTapped: StyleHelper.restartWithStyle(card.modelData)
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
