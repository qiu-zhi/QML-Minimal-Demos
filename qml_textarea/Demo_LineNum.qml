import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 带行号编辑器：使用 TextAreaItem 组件实现行号与文本同步滚动
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "带行号的文本编辑器"
            description: "左侧行号区与右侧文本区共享滚动，行号随文本增删自动更新"
        }

        // 使用自定义文本编辑器组件
        TextAreaItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: "请输入文本，行号会自动显示..."
        }
    }
}
