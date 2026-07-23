import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "DelayButton - 延迟按钮"
            description: "需长按一段时间才能触发的按钮，进度可视化显示"
        }

        DelayButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 200
            Layout.preferredHeight: 40
            text: "确认格式化" + " (" + Math.round(progress * 100) + "%)"
            font.pointSize: 13
            delay: 2000 // 默认2s延迟，可修改
            onActivated: textResult.text = "Format Partition ..."
        }

        Text {
            id: textResult
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
