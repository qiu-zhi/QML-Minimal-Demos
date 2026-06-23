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

    onVisibleChanged: {
        if (visible) {
            opacity = 0
            opacity = 1
        }
    }

    default property alias content: contentContainer.data

    Item {
        id: contentContainer
        anchors.fill: parent
    }
}
