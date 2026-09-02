import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: 200
    height: 260
    color: "#fff"
    radius: 12
    border.color: "#ccc"
    border.width: 1

    property int hours: hoursTumbler.currentIndex
    property int minutes: minutesTumbler.currentIndex

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Item { Layout.fillWidth: true }

            Tumbler {
                Layout.preferredWidth: 100
                Layout.fillHeight: true
                id: hoursTumbler
                model: 24
                visibleItemCount: 6
                wrap: true

                delegate: Text {
                    text: modelData.toString().padStart(2, '0')
                    color: Tumbler.tumbler.currentIndex === index ? "#1976D2" : "#999"
                    font.pixelSize: Tumbler.tumbler.currentIndex === index ? 22 : 18
                    font.bold: Tumbler.tumbler.currentIndex === index
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / 2.5
                }
            }

            Text {
                text: ":"
                font.pixelSize: 22
                font.bold: true
                color: "#1976D2"
            }

            Tumbler {
                Layout.preferredWidth: 100
                Layout.fillHeight: true
                id: minutesTumbler
                model: 60
                visibleItemCount: 6
                wrap: true

                delegate: Text {
                    text: modelData.toString().padStart(2, '0')
                    color: Tumbler.tumbler.currentIndex === index ? "#1976D2" : "#999"
                    font.pixelSize: Tumbler.tumbler.currentIndex === index ? 22 : 18
                    font.bold: Tumbler.tumbler.currentIndex === index
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / 2.5
                }
            }

            Item { Layout.fillWidth: true }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.margins: 10
            color: "#1976D2"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: hours.toString().padStart(2, '0') + ":" + minutes.toString().padStart(2, '0')
                font.pixelSize: 18
                font.bold: true
                color: "#fff"
            }
        }
    }
}
