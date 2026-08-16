import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Material 样式"
            description: "使用 Material 风格，通过 Material 附加属性设置主题色、文字颜色和阴影高度"
        }

        ComboBox {
            id: professionalCombo
            Layout.fillWidth: true
            Layout.preferredHeight: 30

            model: ["选项1", "选项2"]

            // 使用Material设计风格
            // 注意：background 不能直接用 Material.primary（深色主色）——
            // Light 主题下 Material.primaryTextColor 是深色文字（rgba(0,0,0,0.87)），
            // 深底深字对比度不足会看不清。
            // 改用 primary 的浅色变体（Shade50）做背景，既有主题色又保证文字清晰
            Material.background: Material.color(Material.Indigo, Material.Shade50)
            Material.foreground: Material.primaryTextColor
            Material.elevation: 2
        }

        Text {
            Layout.fillWidth: true
            color: "#999"
            font.pointSize: 10
            text: "提示：Material.background 用 primary 浅色变体保证文字对比度，Material.elevation 设置阴影高度"
        }

        Item { Layout.fillHeight: true }
    }
}
