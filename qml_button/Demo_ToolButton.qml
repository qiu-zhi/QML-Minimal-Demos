import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ToolButton - 菜单按钮"
            description: "工具按钮，常用于工具栏，可弹出菜单执行操作"
        }

        ToolButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 160
            Layout.preferredHeight: 40
            icon.source: "qrc:/icons/file.png"
            icon.width: 32
            icon.height: 32
            text: "打开菜单"
            font.pointSize: 13

            onClicked: menu.open()

            Menu {
                id: menu
                MenuItem { text: "复制"; onTriggered: textResult.text = "选择了复制" }
                MenuItem { text: "粘贴"; onTriggered: textResult.text = "选择了粘贴" }
                MenuSeparator {}
                MenuItem { text: "新建"; onTriggered: textResult.text = "选择了新建" }
            }
        }

        Text {
            id: textResult
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}
