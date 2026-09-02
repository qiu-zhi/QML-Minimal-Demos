import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: 260
    height: 320
    color: "#fff"
    radius: 12
    border.color: "#e8e8e8"
    border.width: 1

    property date selectedDateTime: new Date()

    function updateDateTime() {
        if (yearTumbler.currentIndex < 0 || dayTumbler.currentIndex < 0) return;

        let year = parseInt(yearTumbler.model[yearTumbler.currentIndex])
        let month = monthTumbler.currentIndex
        let day = dayTumbler.currentIndex + 1
        let hours = hoursTumbler.currentIndex
        let minutes = minutesTumbler.currentIndex

        if (isNaN(year) || isNaN(day)) return;

        let newDate = new Date(selectedDateTime)
        newDate.setDate(1)
        newDate.setFullYear(year)
        newDate.setMonth(month)
        newDate.setDate(day)
        newDate.setHours(hours)
        newDate.setMinutes(minutes)

        if (newDate.getTime() === selectedDateTime.getTime()) return;
        selectedDateTime = newDate
    }

    function getDaysInMonth(year, month) {
        return new Date(year, month + 1, 0).getDate()
    }

    Component.onCompleted: {
        let currentDate = new Date()
        let currentYear = currentDate.getFullYear().toString()
        yearTumbler.currentIndex = yearTumbler.model.indexOf(currentYear)
        monthTumbler.currentIndex = currentDate.getMonth()
        dayTumbler.model = getDaysInMonth(currentDate.getFullYear(), currentDate.getMonth())
        dayTumbler.currentIndex = currentDate.getDate() - 1
        hoursTumbler.currentIndex = currentDate.getHours()
        minutesTumbler.currentIndex = currentDate.getMinutes()
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 6

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 100

            Row {
                anchors.centerIn: parent
                spacing: 2

                Tumbler {
                    id: yearTumbler
                    model: Array.from({length: 21}, (_, i) => (2020 + i).toString())
                    height: 100
                    width: 60
                    visibleItemCount: 3

                    delegate: Text {
                        text: modelData
                        color: Tumbler.tumbler.currentIndex === index ? "#1976D2" : "#999"
                        font.pixelSize: Tumbler.tumbler.currentIndex === index ? 14 : 11
                        font.bold: Tumbler.tumbler.currentIndex === index
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / 1.5
                    }
                    onCurrentIndexChanged: Qt.callLater(updateDateTime)
                }

                Tumbler {
                    id: monthTumbler
                    model: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
                    height: 100
                    width: 40
                    visibleItemCount: 3

                    delegate: Text {
                        text: modelData
                        color: Tumbler.tumbler.currentIndex === index ? "#1976D2" : "#999"
                        font.pixelSize: Tumbler.tumbler.currentIndex === index ? 14 : 11
                        font.bold: Tumbler.tumbler.currentIndex === index
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / 1.5
                    }
                    onCurrentIndexChanged: {
                        if (yearTumbler.currentIndex >= 0) {
                            let year = parseInt(yearTumbler.model[yearTumbler.currentIndex])
                            let daysInMonth = getDaysInMonth(year, currentIndex)
                            dayTumbler.model = daysInMonth
                            Qt.callLater(updateDateTime)
                        }
                    }
                }

                Tumbler {
                    id: dayTumbler
                    model: 31
                    height: 100
                    width: 35
                    visibleItemCount: 3

                    delegate: Text {
                        text: (modelData + 1).toString()
                        color: Tumbler.tumbler.currentIndex === index ? "#1976D2" : "#999"
                        font.pixelSize: Tumbler.tumbler.currentIndex === index ? 14 : 11
                        font.bold: Tumbler.tumbler.currentIndex === index
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / 1.5
                    }
                    onCurrentIndexChanged: Qt.callLater(updateDateTime)
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            color: "#e0e0e0"
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 100

            Row {
                anchors.centerIn: parent
                spacing: 4

                Tumbler {
                    id: hoursTumbler
                    model: 24
                    height: 100
                    width: 45
                    visibleItemCount: 3
                    wrap: true

                    delegate: Text {
                        text: modelData.toString().padStart(2, '0')
                        color: Tumbler.tumbler.currentIndex === index ? "#1976D2" : "#999"
                        font.pixelSize: Tumbler.tumbler.currentIndex === index ? 16 : 12
                        font.bold: Tumbler.tumbler.currentIndex === index
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / 1.5
                    }
                    onCurrentIndexChanged: Qt.callLater(updateDateTime)
                }

                Text {
                    text: ":"
                    font.pixelSize: 18
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#1976D2"
                }

                Tumbler {
                    id: minutesTumbler
                    model: 60
                    height: 100
                    width: 45
                    visibleItemCount: 3
                    wrap: true

                    delegate: Text {
                        text: modelData.toString().padStart(2, '0')
                        color: Tumbler.tumbler.currentIndex === index ? "#1976D2" : "#999"
                        font.pixelSize: Tumbler.tumbler.currentIndex === index ? 16 : 12
                        font.bold: Tumbler.tumbler.currentIndex === index
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / 1.5
                    }
                    onCurrentIndexChanged: Qt.callLater(updateDateTime)
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            Layout.margins: 10
            color: "#1976D2"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: selectedDateTime.toLocaleString(Qt.locale(), "yyyy-MM-dd hh:mm")
                font.pixelSize: 14
                font.bold: true
                color: "#fff"
            }
        }
    }
}
