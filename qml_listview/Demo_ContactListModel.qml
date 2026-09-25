import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./components"

// Demo：QSortFilterProxyModel 大数据量联系人列表（10万条，实时过滤）
FadeInAnimation {

    property int currentEditIndex: -1

    ContactDialog {
        id: addContactDialogModel
        isEdit: false
        anchors.centerIn: parent
        onContactConfirmed: function(name, phone) {
            contactProxyModel.sourceModel.addContact(name, phone)
        }
    }

    ContactDialog {
        id: editContactDialogModel
        isEdit: true
        anchors.centerIn: parent
        onContactConfirmed: function(name, phone) {
            contactProxyModel.editContact(currentEditIndex, name, phone)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "联系人列表（ProxyModel）"
            description: "QSortFilterProxyModel 实时过滤 10 万条联系人数据"
        }

        // 工具栏
        Rectangle {
            Layout.fillWidth: true
            height: 44
            color: "#f0f0f0"
            radius: 5

            RowLayout {
                anchors.fill: parent
                anchors.margins: 6
                spacing: 8

                CustomTextField {
                    id: searchFieldModel
                    Layout.fillWidth: true
                    placeholderText: "搜索联系人..."
                    leftIcon: "qrc:/icons/find.png"
                    onTextChanged: contactProxyModel.filterString = text
                    onRightIconClicked: {
                        text = ""
                        contactProxyModel.filterString = ""
                    }
                }

                IconButton {
                    text: "添加"
                    iconSource: "qrc:/icons/add.png"
                    showBackground: true
                    backgroundColor: "#BBDEFB"
                    onClicked: addContactDialogModel.open()
                }
            }
        }

        // 列表区域（带滚动条）
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#ffffff"
            radius: 5

            Item {
                anchors.fill: parent
                anchors.margins: 1

                ListView {
                    id: proxyListView
                    anchors.fill: parent
                    anchors.rightMargin: proxyScrollBar.width
                    model: contactProxyModel
                    spacing: 6
                    clip: true
                    ScrollBar.vertical: proxyScrollBar

                    delegate: Rectangle {
                        width: proxyListView.width
                        height: 55
                        color: "#f5f5f5"
                        radius: 5

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: { parent.color = "#e8e8e8"; rowTip.visible = true }
                            onExited:  { parent.color = "#f5f5f5"; rowTip.visible = false }
                        }

                        ToolTip {
                            id: rowTip
                            text: {
                                const n = index + 1
                                return "第 " + n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 行"
                            }
                            delay: 500
                            timeout: 5000
                            visible: false
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 10

                            Rectangle {
                                width: 36; height: 36; radius: 18
                                color: {
                                    const colors = ["#FF6B6B","#4ECDC4","#45B7D1","#96CEB4","#D4A5A5","#9B59B6"]
                                    return colors[firstLetter.charCodeAt(0) % colors.length]
                                }
                                Text {
                                    anchors.centerIn: parent
                                    text: firstLetter
                                    color: "white"
                                    font.pixelSize: 18
                                    font.bold: true
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 4
                                Text { text: name;  font.bold: true; font.pixelSize: 14; Layout.fillWidth: true }
                                Text { text: phone; color: "#666";  font.pixelSize: 12; Layout.fillWidth: true }
                            }

                            RowLayout {
                                spacing: 6
                                IconButton {
                                    iconSource: "qrc:/icons/edit.png"
                                    onClicked: {
                                        currentEditIndex = index
                                        editContactDialogModel.currentName  = name
                                        editContactDialogModel.currentPhone = phone
                                        editContactDialogModel.open()
                                    }
                                }
                                IconButton {
                                    iconSource: "qrc:/icons/delete.png"
                                    onClicked: contactProxyModel.removeContact(index)
                                }
                            }
                        }
                    }
                }

                ScrollBar {
                    id: proxyScrollBar
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    active: true
                    interactive: true
                    orientation: Qt.Vertical
                }
            }
        }
    }
}
