import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "时间戳转换"
            description: "使用 getTime() 获取时间戳，new Date(timestamp) 将时间戳转回日期"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 12

                Text {
                    text: "Date → 时间戳"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#1976D2"
                }

                Text {
                    property date d: new Date()
                    property var ts: d.getTime()
                    text: "当前日期: " + d.toLocaleString(Qt.locale())
                          + "\n时间戳(毫秒): " + ts
                          + "\n时间戳(秒): " + Math.floor(ts / 1000)
                    font.pixelSize: 13
                    color: "#333"
                    lineHeight: 1.5
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#e0e0e0"
                }

                Text {
                    text: "时间戳 → Date"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#1976D2"
                }

                Text {
                    property var ts: 1745590669000
                    property date d: new Date(ts)
                    text: "时间戳: " + ts
                          + "\n转换为日期: " + d.toLocaleString(Qt.locale())
                    font.pixelSize: 13
                    color: "#333"
                    lineHeight: 1.5
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
