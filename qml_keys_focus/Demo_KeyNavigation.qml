import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "KeyNavigation 方向键导航"
            description: "KeyNavigation 附加属性为方向键提供声明式焦点跳转目标。常用于网格类、卡片选择、九宫格菜单。"
        }

        // 3x3 网格，方向键导航
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 280
            radius: 10
            color: "#FAFAFA"
            border.color: "#ddd"
            border.width: 1

            Grid {
                id: grid
                anchors.centerIn: parent
                columns: 3
                spacing: 12

                // 保存 9 个格子
                property var cells: []

                Repeater {
                    model: 9
                    delegate: Rectangle {
                        id: cell
                        required property int index

                        width: 90
                        height: 70
                        radius: 8
                        color: cell.activeFocus ? "#1296FF" : "#FFF"
                        border.color: cell.activeFocus ? "#1296FF" : "#ccc"
                        border.width: cell.activeFocus ? 2 : 1

                        // 让矩形本身可获取焦点
                        activeFocusOnTab: true

                        // 把自己登记到 grid.cells，供导航使用
                        Component.onCompleted: grid.cells[index] = cell

                        Text {
                            anchors.centerIn: parent
                            text: (index + 1)
                            font.pointSize: 20
                            font.bold: true
                            color: cell.activeFocus ? "#FFF" : "#666"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: cell.forceActiveFocus()
                        }
                    }
                }

                // 所有格子创建完成后，统一设置方向键导航目标
                Component.onCompleted: {
                    for (var i = 0; i < grid.cells.length; i++) {
                        var c = grid.cells[i]
                        c.KeyNavigation.right = (i % 3 < 2) ? grid.cells[i + 1] : null
                        c.KeyNavigation.left  = (i % 3 > 0) ? grid.cells[i - 1] : null
                        c.KeyNavigation.down  = (Math.floor(i / 3) < 2) ? grid.cells[i + 3] : null
                        c.KeyNavigation.up    = (Math.floor(i / 3) > 0) ? grid.cells[i - 3] : null
                    }
                }
            }
        }

        // 状态提示
        Text {
            text: "提示：方向键 / Tab 切换单元格，鼠标点击亦可"
            font.pointSize: 11
            color: "#666"
        }

        Item { Layout.fillHeight: true }
    }
}
