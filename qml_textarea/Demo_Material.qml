import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// Material风格：使用 Material 主题，输入框聚焦时显示 accent 下划线动画
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "Material 风格"
            description: "借助 QtQuick.Controls.Material，输入框聚焦时下划线以 accent 色动画过渡"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#ffffff"
            radius: 8
            border.width: 1
            border.color: "#e0e0e0"

            ScrollView {
                id: scrollView
                anchors.fill: parent
                anchors.margins: 8

                TextArea {
                    id: materialTextArea
                    width: scrollView.width
                    height: scrollView.height

                    // 基本属性
                    placeholderText: "请输入文本..."
                    placeholderTextColor: "#999999"
                    font.pixelSize: 16
                    wrapMode: TextArea.Wrap

                    Rectangle {
                        width: parent.width
                        anchors.bottom: parent.bottom
                        color: parent.activeFocus ? Material.accent : "#e0e0e0"

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }
            }
        }
    }
}
