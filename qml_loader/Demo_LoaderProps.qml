import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "属性传递"
            description: "向 Loader 加载的组件传递自定义属性，实现动态内容更新"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            TextField {
                id: textInput
                placeholderText: "输入文字"
                Layout.fillWidth: true
                maximumLength: 10
            }

            ComboBox {
                id: colorPicker
                Layout.fillWidth: true
                model: [
                    { text: "红色", color: "#e74c3c" },
                    { text: "蓝色", color: "#3498db" },
                    { text: "绿色", color: "#2ecc71" },
                    { text: "紫色", color: "#9b59b6" }
                ]
                textRole: "text"
                currentIndex: 0
            }

            Button {
                text: "应用"
                onClicked: {
                    if (loader.item) {
                        loader.item.displayText = textInput.text || "Hello"
                        loader.item.displayBgColor = colorPicker.model[colorPicker.currentIndex].color
                    }
                }
            }

            Button {
                text: "重置"
                onClicked: {
                    textInput.text = ""
                    colorPicker.currentIndex = 0
                    if (loader.item) {
                        loader.item.displayText = "Hello"
                        loader.item.displayBgColor = colorPicker.model[colorPicker.currentIndex].color
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Qt.rgba(0.95, 0.95, 0.95, 1)
            radius: 4

            Loader {
                id: loader
                anchors.fill: parent
                anchors.margins: 10
                sourceComponent: displayComponent
                onLoaded: {
                    item.displayText = textInput.text || "Hello"
                    item.displayBgColor = colorPicker.model[colorPicker.currentIndex].color
                }
            }
        }
    }

    Component {
        id: displayComponent
        Rectangle {
            id: inner
            property string displayText: "Hello"
            property color displayBgColor: "#e74c3c"
            color: inner.displayBgColor
            radius: 6
            opacity: 0.9

            Text {
                anchors.centerIn: parent
                text: inner.displayText
                color: "#fff"
                font.pixelSize: 24
                font.bold: true
            }
        }
    }
}
