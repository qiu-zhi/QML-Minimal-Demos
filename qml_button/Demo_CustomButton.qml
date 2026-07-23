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
            title: "CustomButton - 自定义按钮"
            description: "通过自定义 background 和 contentItem 实现的按钮组件"
        }

        // 按钮组件
        CustomButton {
            Layout.fillWidth: true
            Layout.preferredHeight: 60

            // 这里覆盖 CustomButton 中定义的属性
            buttonText: "CustomButton"
            description: "重新定义了按钮背景、文本内容"
            bgColor: "#3498db"

            onClicked: {
                textResult.text = "clicked !"
            }
        }

        Text {
            id: textResult
            Layout.alignment: Qt.AlignLeft
        }

        Item { Layout.fillHeight: true }
    }
}
