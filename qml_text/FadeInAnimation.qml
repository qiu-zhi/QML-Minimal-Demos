import QtQuick

Item {
    id: root

    property int fadeInDuration: 500
    property var fadeInEasingType: Easing.OutQuad

    opacity: 0

    default property alias content: contentContainer.data

    Item {
        id: contentContainer
        anchors.fill: parent
    }

    states: [
        State {
            name: "visible"
            when: root.visible
            PropertyChanges { target: root; opacity: 1 }
        }
    ]

    transitions: [
        Transition {
            from: ""; to: "visible"
            NumberAnimation {
                property: "opacity"
                duration: root.fadeInDuration
                easing.type: root.fadeInEasingType
            }
        }
    ]
}
