import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "排列方向"
            description: "flow 决定先横排还是先竖排，layoutDirection 与 verticalLayoutDirection 分别控制水平、垂直方向。"
        }

        // 控制条
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            // flow 可选 FlowLeftToRight / FlowTopToBottom
            CheckBox {
                id: flowCheck
                text: "先竖排"
                font.pointSize: 10
            }

            // layoutDirection 可选 LeftToRight / RightToLeft
            CheckBox {
                id: rtlCheck
                text: "水平反向"
                font.pointSize: 10
            }

            // verticalLayoutDirection 可选 TopToBottom / BottomToTop
            CheckBox {
                id: bottomUpCheck
                text: "垂直反向"
                font.pointSize: 10
            }

            Item { Layout.fillWidth: true }

            Text {
                text: "共 " + grid.count + " 项"
                font.pointSize: 10
                color: "#666"
            }
        }

        // 内容卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            GridView {
                id: grid
                anchors.fill: parent
                anchors.margins: 10
                clip: true

                cellWidth: 70
                cellHeight: 60

                flow: flowCheck.checked ? GridView.FlowTopToBottom : GridView.FlowLeftToRight
                layoutDirection: rtlCheck.checked ? Qt.RightToLeft : Qt.LeftToRight
                verticalLayoutDirection: bottomUpCheck.checked ? GridView.BottomToTop : GridView.TopToBottom

                model: 40

                delegate: Item {
                    required property int index

                    width: grid.cellWidth
                    height: grid.cellHeight

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 4
                        radius: 8
                        color: "#FFFFFF"
                        border.color: "#e0e0e0"
                        border.width: 1

                        Text {
                            anchors.centerIn: parent
                            text: index + 1
                            color: "#333"
                            font.pointSize: 12
                            font.bold: true
                        }
                    }
                }
            }
        }
    }
}
