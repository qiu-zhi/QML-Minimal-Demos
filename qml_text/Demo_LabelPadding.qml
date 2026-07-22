import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Label 内边距控制"
            description: "演示 Label 的 padding 属性：统一内边距、top/bottom/left/rightPadding 独立控制"
        }

        Label {
            text: "默认内边距"
            padding: 10
            background: Rectangle { color: "#e8f5e9"; border.color: "#66bb6a" }
        }

        Label {
            text: "自定义内边距"
            padding: 10
            topPadding: 20
            bottomPadding: 20
            leftPadding: 30
            rightPadding: 30
            background: Rectangle { color: "#fff3e0"; border.color: "#ffb74d" }
        }

        Item { Layout.fillHeight: true }

        Note {
            text: "- padding: 统一内边距\n- topPadding/bottomPadding\n- leftPadding/rightPadding\n- inset属性 (背景相关)"
        }
    }
}
