import QtQuick
import QtQuick.Layouts

FadeInAnimation {

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Flipable 翻转卡片"
            description: "点击卡片触发翻转动画，通过 Rotation 实现正反面切换"
        }

        Flipable {
            id: flipable
            Layout.fillWidth: true
            Layout.fillHeight: true

            property bool flipped: false

            front: Image {
                anchors.fill: parent
                source: "qrc:/images/SpadeA.png"
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            back: Image {
                anchors.fill: parent
                source: "qrc:/images/Background.png"
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            transform: Rotation {
                id: rotation
                origin.x: flipable.width / 2
                origin.y: flipable.height / 2
                axis.x: 0; axis.y: 1; axis.z: 0
                angle: 0
            }

            states: State {
                name: "back"
                when: flipable.flipped
                PropertyChanges { target: rotation; angle: 180 }
            }

            transitions: Transition {
                NumberAnimation {
                    target: rotation
                    property: "angle"
                    duration: 600
                    easing.type: Easing.InOutQuad
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: flipable.flipped = !flipable.flipped
            }
        }

        Text {
            text: "当前: " + (flipable.flipped ? "背面" : "正面")
            font.pointSize: 10
            color: "#666"
        }
    }
}
