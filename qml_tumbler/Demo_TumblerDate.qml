import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "年月日选择"
            description: "使用三个 Tumbler 分别选择月份、日期和年份"
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15

            // 月份选择器
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "月份"
                    font.pointSize: 11
                    color: "#666"
                }
                Tumbler {
                    id: monthTumbler
                    width: 100
                    model: ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                }
            }

            // 日期选择器
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "日"
                    font.pointSize: 11
                    color: "#666"
                }
                Tumbler {
                    id: dayTumbler
                    width: 70
                    model: 31
                }
            }

            // 年份选择器
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "年"
                    font.pointSize: 11
                    color: "#666"
                }
                Tumbler {
                    id: yearTumbler
                    width: 90
                    model: ListModel {
                        Component.onCompleted: {
                            for (var i = 2020; i <= 2030; ++i)
                                append({value: i.toString()})
                        }
                    }
                    delegate: Text {
                        text: value
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "当前选择: " +
                  monthTumbler.model[monthTumbler.currentIndex] + " " +
                  (dayTumbler.currentIndex + 1) + ", " +
                  yearTumbler.model.get(yearTumbler.currentIndex).value
            font.pointSize: 13
            color: "#1296FF"
            font.bold: true
        }

        Item { Layout.fillHeight: true }
    }
}
