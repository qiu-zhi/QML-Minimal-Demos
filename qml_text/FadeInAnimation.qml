// qml_text/FadeInAnimation.qml
import QtQuick

Item {
    id: root

    property int fadeInDuration: 500
    property var fadeInEasingType: Easing.OutQuad

    opacity: 0

    Behavior on opacity {
        NumberAnimation {
            duration: root.fadeInDuration
            easing.type: root.fadeInEasingType
        }
    }

    Component.onCompleted: {
        root.opacity = 1
    }

    default property alias content: contentContainer.data

    Item {
        id: contentContainer
        anchors.fill: parent
    }
}
