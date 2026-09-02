import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "时间选择器"
            description: "使用 Tumbler 滚轮选择小时和分钟"
        }

        TimePicker {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Item { Layout.fillHeight: true }
    }
}
