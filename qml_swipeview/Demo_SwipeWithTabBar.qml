import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "SwipeView 与 TabBar"
            description: "TabBar 与 SwipeView 联动，点击 Tab 切换页面"
        }

        ListModel {
            id: listModel
            ListElement { demoText: "Page1"; demoDes: "This is Page1" }
            ListElement { demoText: "Page2"; demoDes: "This is Page2" }
            ListElement { demoText: "Page3"; demoDes: "This is Page3" }
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true
            currentIndex: swipeView.currentIndex
            Repeater {
                model: listModel
                delegate: TabButton {
                    text: demoText
                    onClicked: swipeView.currentIndex = index
                }
            }
        }

        SwipeView {
            id: swipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            Repeater {
                model: listModel
                delegate: CustomRect {
                    description: demoDes
                }
            }
        }
    }
}
