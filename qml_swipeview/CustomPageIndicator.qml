import QtQuick
import QtQuick.Controls

PageIndicator {
    interactive: true
    spacing: 10

    delegate: Column {
        spacing: 10

        Rectangle {
            width: 12
            height: 12
            radius: 6
            color: index === swipeView.currentIndex ? "#1296ff" : "#e0e0e0"

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }
}
