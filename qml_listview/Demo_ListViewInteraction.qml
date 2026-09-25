import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./components"

// Demo：ListView 数据交互（增删改、输入绑定）
FadeInAnimation {

    ListModel {
        id: fruitModel
        ListElement { fruitName: "苹果"; price: "8.0" }
        ListElement { fruitName: "香蕉"; price: "3.5" }
        ListElement { fruitName: "橙子"; price: "6.0" }
        ListElement { fruitName: "草莓"; price: "10.0" }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "ListView 数据交互"
            description: "ListModel 增删改、输入框绑定、按钮操作"
        }

        // 添加输入区
        RowLayout {
            Layout.fillWidth: true
            spacing: 6

            CustomTextField {
                id: nameInput
                placeholderText: "名称"
                Layout.fillWidth: true
            }

            CustomTextField {
                id: priceInput
                placeholderText: "价格"
                Layout.preferredWidth: 60
            }

            IconButton {
                text: "添加"
                iconSource: "qrc:/icons/add.png"
                showBackground: true
                backgroundColor: "#BBDEFB"
                onClicked: {
                    if (nameInput.text && priceInput.text) {
                        fruitModel.append({ "fruitName": nameInput.text, "price": priceInput.text })
                        nameInput.text = ""
                        priceInput.text = ""
                    }
                }
            }
        }

        // 列表
        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: fruitModel
            clip: true
            spacing: 4

            delegate: Rectangle {
                width: listView.width
                height: 40
                radius: 4
                color: "#f5f5f5"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 8

                    Text {
                        text: fruitName
                        Layout.fillWidth: true
                        font.pixelSize: 13
                    }
                    Text {
                        text: price + " 元"
                        color: "#E67E22"
                        font.pixelSize: 13
                    }
                    Button {
                        text: "删除"
                        implicitHeight: 26
                        implicitWidth: 44
                        font.pixelSize: 11
                        onClicked: fruitModel.remove(index)
                    }
                }
            }
        }
    }
}
