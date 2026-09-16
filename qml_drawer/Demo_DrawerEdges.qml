import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    // 左侧导航抽屉中最近一次点击的菜单项
    property string selectedNav: "首页"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Drawer 抽屉方向"
            description: "Drawer 通过 edge 属性决定从哪条边滑出：Qt.TopEdge / Qt.RightEdge / Qt.BottomEdge / Qt.LeftEdge。四个按钮集中在同一页，分别打开各自方向的抽屉。"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"

            GridLayout {
                anchors.fill: parent
                anchors.margins: 20
                columns: 2
                columnSpacing: 20
                rowSpacing: 15

                CustomButton {
                    bgColor: "#2ecc71"
                    buttonText: "顶部抽屉"
                    description: "edge: Qt.TopEdge · 消息通知"
                    onClicked: topDrawer.open()
                }

                CustomButton {
                    bgColor: "#e74c3c"
                    buttonText: "右侧抽屉"
                    description: "edge: Qt.RightEdge · 功能设置"
                    onClicked: rightDrawer.open()
                }

                CustomButton {
                    bgColor: "#f39c12"
                    buttonText: "底部抽屉"
                    description: "edge: Qt.BottomEdge · 常用功能"
                    onClicked: bottomDrawer.open()
                }

                CustomButton {
                    bgColor: "#3498db"
                    buttonText: "左侧导航"
                    description: "edge: Qt.LeftEdge · 主导航菜单"
                    onClicked: leftDrawer.open()
                }

                Text {
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    font.pixelSize: 12
                    color: "#666"
                    wrapMode: Text.Wrap
                    text: "提示：Drawer 是模态弹窗，打开后点击遮罩区域、按 Esc 键或点击面板条目均可关闭。"
                }

                Item {
                    Layout.columnSpan: 2
                    Layout.fillHeight: true
                }
            }
        }
    }

    // 四个方向的抽屉：各自是独立组件文件，页面只负责挂载与打开
    TopNoticeDrawer { id: topDrawer }
    RightSettingsDrawer { id: rightDrawer }
    BottomQuickDrawer { id: bottomDrawer }
    LeftNavDrawer {
        id: leftDrawer
        // 导航项被选中时，同步给页面做"最近选择"反馈
        onItemSelected: (text) => root.selectedNav = text
    }
}
