import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "日期时间选择器"
            description: "使用 Tumbler 组合选择年、月、日、时、分"
        }

        DateTimePicker {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Item { Layout.fillHeight: true }
    }
}
