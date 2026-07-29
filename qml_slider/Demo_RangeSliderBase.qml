import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "RangeSlider 基础"
            description: "QML RangeSlider 组件的基本用法，可拖动选择范围"
        }

        // 显示使用说明
        Text {
            text: "拖动滑块来选择范围"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        // RangeSlider 组件
        RangeSlider {
            id: rangeSlider
            from: 0
            to: 100
            first.value: 20
            second.value: 80
            stepSize: 1
            Layout.fillWidth: true
        }

        // 显示当前值的文本
        Text {
            text: "当前范围: " + Math.round(rangeSlider.first.value) + " - " + Math.round(rangeSlider.second.value)
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
