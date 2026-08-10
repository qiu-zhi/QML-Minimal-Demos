import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 换行模式：演示 TextArea.NoWrap / Wrap / WrapAnywhere 三种换行模式
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "换行模式"
            description: "通过按钮切换 NoWrap、Wrap、WrapAnywhere 三种换行模式"
        }

        TextArea {
            id: wrapTextArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "TextArea is not scrollable by itself. Especially on screen-size constrained platforms, it is often preferable to make entire application pages scrollable. On such a scrollable page, a non-scrollable TextArea might behave better than nested scrollable controls."
            placeholderText: "选择换行模式..."
            clip: true
            selectByMouse: true

            background: Rectangle {
                color: wrapTextArea.enabled ? "white" : "#f5f5f5"
                border.color: wrapTextArea.activeFocus ? "#1296FF" : "#c0c0c0"
                border.width: wrapTextArea.activeFocus ? 2 : 1
                radius: 4
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            Button {
                text: "不换行"
                onClicked: {
                    wrapTextArea.wrapMode = TextArea.NoWrap
                    // 让 wrapMode 立即生效
                    wrapTextArea.width = wrapTextArea.width - 1
                    wrapTextArea.width = wrapTextArea.width + 1
                }
            }

            Button {
                text: "单词换行"
                onClicked: {
                    wrapTextArea.wrapMode = TextArea.Wrap
                    wrapTextArea.width = wrapTextArea.width - 1
                    wrapTextArea.width = wrapTextArea.width + 1
                }
            }

            Button {
                text: "任意位置换行"
                onClicked: {
                    wrapTextArea.wrapMode = TextArea.WrapAnywhere
                    wrapTextArea.width = wrapTextArea.width - 1
                    wrapTextArea.width = wrapTextArea.width + 1
                }
            }

            Label {
                text: {
                    switch (wrapTextArea.wrapMode) {
                        case TextArea.NoWrap: return "当前模式: 不换行"
                        case TextArea.Wrap: return "当前模式: 单词换行"
                        case TextArea.WrapAnywhere: return "当前模式: 任意位置换行"
                        default: return "当前模式: 未知"
                    }
                }
                color: "#1296FF"
                font.bold: true
            }
        }
    }
}
