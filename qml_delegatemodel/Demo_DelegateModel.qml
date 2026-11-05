import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

FadeInAnimation {
    id: root

    ListModel {
        id: cityModel
        ListElement { city: "北京"; temp: 22 }
        ListElement { city: "上海"; temp: 25 }
        ListElement { city: "广州"; temp: 30 }
        ListElement { city: "成都"; temp: 18 }
        ListElement { city: "西安"; temp: 20 }
    }

    DelegateModel {
        id: cardModel
        model: cityModel

        delegate: Rectangle {
            id: row
            required property int index
            required property string city
            required property int temp

            width: lv.width
            height: 44
            color: ListView.isCurrentItem ? "#E8F4FF" : "#FFFFFF"
            border.color: "#EAEAEA"
            border.width: 1

            Text {
                x: 12
                anchors.verticalCenter: parent.verticalCenter
                text: row.DelegateModel.itemsIndex
                color: "#1296FF"
                font.pointSize: 12
                font.bold: true
            }

            Text {
                x: 40
                anchors.verticalCenter: parent.verticalCenter
                text: row.city
                color: "#333"
                font.pointSize: 12
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                text: row.temp + "°C"
                color: "#999"
                font.pointSize: 11
            }

            MouseArea {
                anchors.fill: parent
                onClicked: lv.currentIndex = row.DelegateModel.itemsIndex
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "委托模型基础"
            description: "DelegateModel 把 model 和 delegate 打包成一个模型对象，视图直接把它当 model 用。"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Button {
                text: "上移"
                font.pointSize: 10
                enabled: lv.currentIndex > 0
                onClicked: {
                    var i = lv.currentIndex
                    cardModel.items.move(i, i - 1, 1)
                    lv.currentIndex = i - 1
                }
            }

            Button {
                text: "下移"
                font.pointSize: 10
                enabled: lv.currentIndex >= 0 && lv.currentIndex < cardModel.items.count - 1
                onClicked: {
                    var i = lv.currentIndex
                    cardModel.items.move(i, i + 1, 1)
                    lv.currentIndex = i + 1
                }
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "模型 " + cardModel.count + " 项 ｜ items 组 " + cardModel.items.count + " 项"
                color: "#666"
                font.pointSize: 10
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FAFAFA"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ListView {
                id: lv
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                spacing: 0
                model: cardModel
                currentIndex: 0
            }
        }
    }
}
