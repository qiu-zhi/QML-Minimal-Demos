import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    property bool darkMode: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "主题切换"
            description: "通过暗色 / 亮色模式切换 TextField 的背景、文字与边框颜色"
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 250
            spacing: 20

            TextField {
                id: themeTextField
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                placeholderText: "多主题文本框"

                background: Rectangle {
                    implicitWidth: 250
                    implicitHeight: 40
                    color: darkMode ? "#333" : "#fff"
                    border.width: themeTextField.activeFocus ? 2 : 1
                    border.color: themeTextField.activeFocus ?
                                  (darkMode ? "#4caf50" : "#21be2b") :
                                  (darkMode ? "#555555" : "#c0c0c0")
                    radius: 4
                }

                color: darkMode ? "#fff" : "#333"
                placeholderTextColor: darkMode ? "#aaa" : "#808080"
            }

            Button {
                Layout.fillWidth: true
                text: darkMode ? "切换至亮色主题" : "切换至暗色主题"
                onClicked: darkMode = !darkMode
            }
        }

        Item { Layout.fillHeight: true }
    }
}
