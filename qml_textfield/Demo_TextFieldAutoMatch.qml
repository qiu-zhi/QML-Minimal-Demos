import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    property var keywords: ["a", "ab", "abc", "bcd", "bcde", "cdef", "cdefg", "cdefgh"]
    property var matches: []

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自动关联"
            description: "输入时弹出 Popup 显示匹配的候选项，点击可自动填充"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 420
            spacing: 20

            Text {
                Layout.fillWidth: true
                text: "测试关键字：" + keywords
                font.pointSize: 10
                color: "#666"
                wrapMode: Text.Wrap
            }

            TextField {
                id: autoCompleteField
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                placeholderText: "输入文本..."

                // 背景样式
                background: Rectangle {
                    color: autoCompleteField.enabled ? "white" : "#f5f5f5"
                    border.color: autoCompleteField.activeFocus ? "#1296FF" :
                                   autoCompleteField.hovered ? "#808080" : "#c0c0c0"
                    border.width: autoCompleteField.activeFocus ? 2 : 1
                    radius: 4
                }

                onTextChanged: {
                    if (text.length > 0) {
                        matches = keywords.filter(function(key) {
                            return key.toLowerCase().indexOf(text.toLowerCase()) === 0
                        })
                        autoCompletePopup.visible = matches.length > 0
                    } else {
                        autoCompletePopup.visible = false
                    }
                }
            }

            // 占位
            Item { Layout.fillHeight: true }
        }
    }

    Popup {
        id: autoCompletePopup
        parent: autoCompleteField
        visible: false

        y: parent.height + 5
        width: parent.width
        height: 180

        contentItem: ListView {
            id: listView
            model: matches
            clip: true

            delegate: ItemDelegate {
                width: parent.width
                height: 30
                text: modelData

                // 文本样式
                contentItem: Text {
                    text: modelData
                    color: parent.hovered ? "#fff" : "#333"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 5
                }

                // 背景色
                background: Rectangle {
                    anchors.fill: parent
                    color: parent.hovered ? "#1296ff" : "#fff"
                }

                onClicked: {
                    autoCompleteField.text = modelData
                    if (typeof autoCompletePopup !== "undefined") {
                        autoCompletePopup.visible = false
                    }
                }

                highlighted: ListView.isCurrentItem
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }

        background: Rectangle {
            border.color: "#d0d0d0"
            radius: 4
        }
    }
}
