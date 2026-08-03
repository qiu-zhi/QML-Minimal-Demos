import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    property int currentYear: new Date().getFullYear()
    property int currentMonth: new Date().getMonth() + 1
    property int currentDay: new Date().getDate()

    // 获取指定年月的天数
    function getDaysInMonth(year, month) {
        return new Date(year, month, 0).getDate()
    }

    // 更新年份模型
    function updateYearModel() {
        var years = []
        for (var i = currentYear - 50; i <= currentYear + 50; ++i) {
            years.push(i)
        }
        yearTumbler.model = years
        yearTumbler.currentIndex = 50  // 设置当前年份位置
    }

    // 更新日期模型
    function updateDayModel() {
        var year = yearTumbler.model[yearTumbler.currentIndex]
        var month = monthTumbler.currentIndex + 1
        var days = getDaysInMonth(year, month)

        var daysArray = []
        for (var i = 1; i <= days; ++i) {
            daysArray.push(i)
        }
        dayTumbler.model = daysArray

        // 确保当前选中的日期有效
        if (dayTumbler.currentIndex >= days) {
            dayTumbler.currentIndex = days - 1
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "日期联动选择"
            description: "年月变化时自动更新日期数量，并显示当前选择的完整日期"
        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 15

            // 年份选择器
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "年份"
                    color: "#666"
                    font.pointSize: 11
                }
                Tumbler {
                    id: yearTumbler
                    model: ListModel {
                        id: yearModel
                    }
                    visibleItemCount: 5
                    delegate: Text {
                        text: modelData
                        color: "#333"
                        font.pixelSize: 16 + (1 - Math.abs(Tumbler.displacement)) * 8
                        opacity: 0.5 + (1 - Math.abs(Tumbler.displacement)) * 0.5
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        width: 120
                    }
                }
            }

            // 月份选择器
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "月份"
                    color: "#666"
                    font.pointSize: 11
                }
                Tumbler {
                    id: monthTumbler
                    model: 12
                    visibleItemCount: 5
                    delegate: Text {
                        text: (modelData + 1) + "月"
                        color: "#333"
                        font.pixelSize: 16 + (1 - Math.abs(Tumbler.displacement)) * 8
                        opacity: 0.5 + (1 - Math.abs(Tumbler.displacement)) * 0.5
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        width: 80
                    }
                }
            }

            // 日期选择器
            Column {
                spacing: 6
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "日期"
                    color: "#666"
                    font.pointSize: 11
                }
                Tumbler {
                    id: dayTumbler
                    model: ListModel {
                        id: dayModel
                    }
                    visibleItemCount: 5
                    delegate: Text {
                        text: modelData + "日"
                        color: "#333"
                        font.pixelSize: 16 + (1 - Math.abs(Tumbler.displacement)) * 8
                        opacity: 0.5 + (1 - Math.abs(Tumbler.displacement)) * 0.5
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        width: 80
                    }
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "当前选择: " +
                  yearTumbler.model[yearTumbler.currentIndex] + "年 " +
                  (monthTumbler.currentIndex + 1) + "月 " +
                  dayTumbler.model[dayTumbler.currentIndex] + "日"
            font.pointSize: 13
            color: "#1296FF"
            font.bold: true
        }

        Item { Layout.fillHeight: true }
    }

    // 监听年月变化，更新日期
    Connections {
        target: yearTumbler
        function onCurrentIndexChanged() { updateDayModel() }
    }

    Connections {
        target: monthTumbler
        function onCurrentIndexChanged() { updateDayModel() }
    }

    Component.onCompleted: {
        updateYearModel()
        monthTumbler.currentIndex = currentMonth - 1
        updateDayModel()
        dayTumbler.currentIndex = currentDay - 1
    }
}
