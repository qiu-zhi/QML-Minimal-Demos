import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "基础示例"
            description: "使用 Tumbler 实现小时、分钟、上下午三个滚轮选择器"
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            // 小时滚轮
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "时"
                    font.pointSize: 11
                    color: "#666"
                }
                Tumbler {
                    id: hoursTumbler
                    model: 24
                    currentIndex: 12
                    height: 140
                }
            }

            // 分钟滚轮
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "分"
                    font.pointSize: 11
                    color: "#666"
                }
                Tumbler {
                    id: minutesTumbler
                    model: 60
                    height: 140
                }
            }

            // 上下午滚轮
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "AM/PM"
                    font.pointSize: 11
                    color: "#666"
                }
                Tumbler {
                    id: amPmTumbler
                    model: ["AM", "PM"]
                    visibleItemCount: 2
                    height: 140
                }
            }
        }

        // 时间显示牌：凸显当前选择
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
            width: 280
            height: 56
            radius: 10
            color: "#EAF4FF"
            border.color: "#1296FF"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: "当前选择: " +
                      (hoursTumbler.currentIndex < 10 ? "0" : "") + hoursTumbler.currentIndex + ":" +
                      (minutesTumbler.currentIndex < 10 ? "0" : "") + minutesTumbler.currentIndex + " " +
                      amPmTumbler.model[amPmTumbler.currentIndex]
                font.pointSize: 16
                font.bold: true
                color: "#1296FF"
            }
        }

        Item { Layout.fillHeight: true }
    }
}
