import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "SwipeView 与指示器"
            description: "SwipeView 基本用法，搭配 PageIndicator 显示当前页码"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            SwipeView {
                id: swipeView
                anchors.fill: parent
                clip: true

                CustomRect { description: "This is CustomRect1" }
                CustomRect { description: "This is CustomRect2" }
                CustomRect { description: "This is CustomRect3" }
            }

            PageIndicator {
                id: indicator
                anchors.bottomMargin: 20
                anchors.bottom: swipeView.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                count: swipeView.count
                currentIndex: swipeView.currentIndex
            }
        }
    }
}
