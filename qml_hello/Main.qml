import QtQuick
import QtQuick.Window

Window {
    id: root
    width: 400
    height: 300
    visible: true
    color: "#fff"
    title: "QML —— Hello World"

    Text {
        id: helloText
        text: "Hello World"
        color: "#fff"
        font.pixelSize: 48
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0

        ColorAnimation {
            id: colorAnim
            target: helloText
            property: "color"
            from: "#fff"
            to: "#333"
            duration: 2000
        }

        NumberAnimation {
            id: bounceAnim
            target: helloText
            property: "y"
            from: 0
            to: (root.height - helloText.height) / 2
            duration: 2000
        }

        Component.onCompleted: {
            bounceAnim.start()
            colorAnim.start()
        }
    }
}
