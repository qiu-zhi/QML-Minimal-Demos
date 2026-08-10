import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "带删除的文本框"
            description: "图标 + 删除按钮的复合样式，输入内容时显示清除按钮"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            TextField {
                id: styledTextField
                Layout.preferredWidth: 250
                Layout.preferredHeight: 40
                placeholderText: "带图标和删除按钮的文本框"

                // 背景样式
                background: Rectangle {
                    implicitWidth: 250
                    implicitHeight: 40
                    color: styledTextField.enabled ? "white" : "#f5f5f5"
                    border.color: styledTextField.activeFocus ? "#21be2b" :
                                  styledTextField.hovered ? "#808080" : "#c0c0c0"
                    border.width: styledTextField.activeFocus ? 2 : 1
                    radius: 8
                }

                Image {
                    source: "/icons/search2.png"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 24
                    height: 24
                }

                // 文本样式
                color: "black"
                selectionColor: "#21be2b"
                selectedTextColor: "white"
                font.pixelSize: 14
                leftPadding: 40
                topPadding: 10
                rightPadding: clearButton.width + 10

                Button {
                    id: clearButton
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                    width: 24
                    height: 24
                    flat: true
                    visible: styledTextField.text !== ""

                    contentItem: Image {
                        source: "/icons/clear.png"
                        anchors.fill: parent
                        width: 24
                        height: 24
                    }

                    onClicked: {
                        styledTextField.text = ""
                        styledTextField.forceActiveFocus()
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
