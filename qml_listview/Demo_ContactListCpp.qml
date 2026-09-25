import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./components"

// Demo：C++ 数据模型驱动的联系人列表（少量数据，含搜索/增删改）
FadeInAnimation {

    property int currentEditIndex: -1

    // 添加联系人对话框
    ContactDialog {
        id: addContactDialog
        isEdit: false
        anchors.centerIn: parent
        onContactConfirmed: function(name, phone) {
            dataModelCpp.addContact(name, phone)
        }
    }

    // 编辑联系人对话框
    ContactDialog {
        id: editContactDialog
        isEdit: true
        anchors.centerIn: parent
        onContactConfirmed: function(name, phone) {
            dataModelCpp.editContact(currentEditIndex, name, phone)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "联系人列表（C++）"
            description: "QAbstractListModel 驱动，支持搜索、添加、编辑、删除"
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
                    id: searchFieldCpp
                    Layout.fillWidth: true
                    placeholderText: "搜索联系人..."
                    leftIcon: "qrc:/icons/find.png"
                    onTextChanged: dataModelCpp.searchContacts(text)
                    onRightIconClicked: {
                        text = ""
                        dataModelCpp.clearSearch()
                    }
                }

                IconButton {
                    text: "添加"
                    iconSource: "qrc:/icons/add.png"
                    showBackground: true
                    backgroundColor: "#BBDEFB"
                    onClicked: addContactDialog.open()
                }
            }
        }

        // 列表
        ListView {
            id: cppListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: dataModelCpp
            spacing: 6
            clip: true

            delegate: Rectangle {
                width: cppListView.width
                height: 55
                color: "#f5f5f5"
                radius: 5

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.color = "#e8e8e8"
                    onExited:  parent.color = "#f5f5f5"
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 10

                    // 首字母头像
                    Rectangle {
                        width: 36
                        height: 36
                        radius: 18
                        color: {
                            const colors = ["#FF6B6B","#4ECDC4","#45B7D1","#96CEB4","#D4A5A5","#9B59B6"]
                            return colors[firstLetter.charCodeAt(0) % colors.length]
                        }
                        Text {
                            anchors.centerIn: parent
                            text: firstLetter
                            color: "white"
                            font.pixelSize: 16
                            font.bold: true
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 4
                        Text { text: name;  font.bold: true; font.pixelSize: 14; Layout.fillWidth: true }
                        Text { text: phone; color: "#666"; font.pixelSize: 12; Layout.fillWidth: true }
                    }

                    RowLayout {
                        spacing: 6
                        IconButton {
                            iconSource: "qrc:/icons/edit.png"
                            onClicked: {
                                currentEditIndex = index
                                editContactDialog.currentName  = name
                                editContactDialog.currentPhone = phone
                                editContactDialog.open()
                            }
                        }
                        IconButton {
                            iconSource: "qrc:/icons/delete.png"
                            onClicked: dataModelCpp.removeContact(index)
                        }
                    }
                }
            }
        }
    }
}
