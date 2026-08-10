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
            title: "自定义文本框"
            description: "自定义 background、文本颜色、选中色、内边距等样式"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            TextField {
                id: styledTextField
                Layout.preferredWidth: 250
                Layout.preferredHeight: 40
                placeholderText: "自定义样式文本框"

                // 背景样式
                background: Rectangle {
                    implicitWidth: 250
                    implicitHeight: 40
                    color: styledTextField.enabled ? "white" : "#f5f5f5"
                    border.color: styledTextField.activeFocus ? "#21be2b" :
                                  styledTextField.hovered ? "#808080" : "#c0c0c0"
                    border.width: styledTextField.activeFocus ? 2 : 1
                    radius: 4
                }

                // 文本样式
                color: "black"
                selectionColor: "#21be2b"
                selectedTextColor: "white"
                font.pixelSize: 14
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
            }
        }

        Item { Layout.fillHeight: true }
    }
}
