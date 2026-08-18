import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    // 当前展开的菜单："" / "file" / "edit" / "view"。
    // 状态定义在文件根对象上（QML 作用域规则：子对象只能通过裸名称
    // 访问文件根对象的属性与函数，中间层对象必须借助 id）。
    property string activeMenu: ""

    // 三个菜单的配置模型（仅静态数据）
    ListModel {
        id: fileModel
        ListElement { label: "新建文件"; key: "Ctrl+N" }
        ListElement { label: "打开文件"; key: "Ctrl+O" }
        ListElement { label: "保存";     key: "Ctrl+S" }
    }
    ListModel {
        id: editModel
        ListElement { label: "撤销"; key: "Ctrl+Z" }
        ListElement { label: "重做"; key: "Ctrl+Y" }
    }
    ListModel {
        id: viewModel
        ListElement { label: "放大"; key: "Ctrl+=" }
        ListElement { label: "缩小"; key: "Ctrl+-" }
    }

    // 展开/收起菜单（再按一次收起）
    function openMenu(m) {
        activeMenu = activeMenu === m ? "" : m
    }

    // 触发菜单项：收起菜单、更新状态栏
    function triggerItem(label, key) {
        activeMenu = ""
        statusText.text = "已执行: " + label + " (" + key + ")"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "快捷键菜单"
            description: "按 Alt+F / Alt+E / Alt+V 展开文件/编辑/视图菜单，再按子菜单快捷键执行对应操作"
        }

        // 展开/收起菜单的快捷键
        Shortcut { sequence: "Alt+F"; onActivated: openMenu("file") }
        Shortcut { sequence: "Alt+E"; onActivated: openMenu("edit") }
        Shortcut { sequence: "Alt+V"; onActivated: openMenu("view") }
        Shortcut {
            sequence: "Esc"
            enabled: activeMenu !== ""
            onActivated: activeMenu = ""
        }

        // 子菜单项快捷键（不展开菜单也能直接使用）
        Shortcut { sequence: "Ctrl+N"; onActivated: triggerItem("新建文件", "Ctrl+N") }
        Shortcut { sequence: "Ctrl+O"; onActivated: triggerItem("打开文件", "Ctrl+O") }
        Shortcut { sequence: "Ctrl+S"; onActivated: triggerItem("保存", "Ctrl+S") }
        Shortcut { sequence: "Ctrl+Z"; onActivated: triggerItem("撤销", "Ctrl+Z") }
        Shortcut { sequence: "Ctrl+Y"; onActivated: triggerItem("重做", "Ctrl+Y") }
        Shortcut { sequence: "Ctrl+="; onActivated: triggerItem("放大", "Ctrl+=") }
        Shortcut { sequence: "Ctrl+-"; onActivated: triggerItem("缩小", "Ctrl+-") }

        // 菜单栏 + 下拉菜单
        Item {
            Layout.preferredHeight: 34
            Layout.fillWidth: true

            Row {
                id: menuBarRow
                spacing: 4

                // 文件菜单按钮
                Rectangle {
                    id: btnFile
                    width: 76
                    height: 30
                    radius: 6
                    color: activeMenu === "file" ? "#1296FF" : "#F5F7FA"
                    border.color: activeMenu === "file" ? "#1296FF" : "#ddd"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "文件(F)"
                        font.pointSize: 11
                        font.bold: true
                        color: activeMenu === "file" ? "white" : "#333"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: openMenu("file")
                    }
                }

                // 编辑菜单按钮
                Rectangle {
                    id: btnEdit
                    width: 76
                    height: 30
                    radius: 6
                    color: activeMenu === "edit" ? "#1296FF" : "#F5F7FA"
                    border.color: activeMenu === "edit" ? "#1296FF" : "#ddd"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "编辑(E)"
                        font.pointSize: 11
                        font.bold: true
                        color: activeMenu === "edit" ? "white" : "#333"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: openMenu("edit")
                    }
                }

                // 视图菜单按钮
                Rectangle {
                    id: btnView
                    width: 76
                    height: 30
                    radius: 6
                    color: activeMenu === "view" ? "#1296FF" : "#F5F7FA"
                    border.color: activeMenu === "view" ? "#1296FF" : "#ddd"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "视图(V)"
                        font.pointSize: 11
                        font.bold: true
                        color: activeMenu === "view" ? "white" : "#333"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: openMenu("view")
                    }
                }
            }

            // 下拉菜单：覆盖在下方内容之上（z 提升）
            Rectangle {
                id: dropdown
                visible: activeMenu !== ""
                z: 100
                width: 170
                radius: 6
                color: "#FFFFFF"
                border.color: "#1296FF"
                border.width: 1
                x: activeMenu === "file" ? btnFile.x
                 : activeMenu === "edit" ? btnEdit.x
                 : btnView.x
                anchors.top: menuBarRow.bottom
                anchors.topMargin: 2

                Column {
                    width: parent.width

                    Repeater {
                        model: activeMenu === "file" ? fileModel
                             : activeMenu === "edit" ? editModel
                             : viewModel
                        delegate: Rectangle {
                            width: parent.width
                            height: 34
                            color: hovered ? "#EAF4FF" : "transparent"
                            property bool hovered: false

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: parent.hovered = true
                                onExited: parent.hovered = false
                                onClicked: triggerItem(label, key)
                            }

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: label
                                font.pointSize: 11
                                color: "#333"
                            }

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: key
                                font.pointSize: 9
                                color: "#999"
                            }
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            text: "按 Alt+F / Alt+E / Alt+V 展开菜单，再按子菜单快捷键执行操作"
            font.pointSize: 12
            color: "#999"
        }

        Item { height: 4 }
    }
}
