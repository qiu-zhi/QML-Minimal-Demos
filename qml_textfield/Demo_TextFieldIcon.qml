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
            title: "带图标的文本框"
            description: "在文本框中嵌入搜索图标，调整 leftPadding 避免文字遮挡"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            TextField {
                id: styledTextField
                Layout.preferredWidth: 250
                Layout.preferredHeight: 40
                placeholderText: "带图标的文本框"

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
                rightPadding: 10
                topPadding: 10
            }
        }

        Item { Layout.fillHeight: true }
    }
}
