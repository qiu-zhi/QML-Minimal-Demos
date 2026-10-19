import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "高亮跟随"
            description: "highlight 是独立于 delegate 的当前项标记，可交给视图托管，也可自行补间跟随。"
        }

        // 控制条
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            CheckBox {
                id: followsCheck
                checked: true
                text: "跟随当前项"
                font.pointSize: 10
            }

            Label {
                text: "时长"
                font.pointSize: 10
            }

            SpinBox {
                id: durBox
                from: 0
                to: 1200
                stepSize: 50
                value: 150
                enabled: followsCheck.checked
                font.pointSize: 10
                Layout.preferredWidth: 84
            }

            Label {
                text: "范围"
                font.pointSize: 10
            }

            ComboBox {
                id: rangeBox
                font.pointSize: 10
                Layout.preferredWidth: 120
                model: ["不限制", "范围生效", "强制范围"]
            }

            Item { Layout.fillWidth: true }
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
                focus: true

                cellWidth: 84
                cellHeight: 84
                model: 40

                highlightFollowsCurrentItem: followsCheck.checked
                highlightMoveDuration: durBox.value

                // NoHighlightRange / ApplyRange / StrictlyEnforceRange
                highlightRangeMode: rangeBox.currentIndex
                preferredHighlightBegin: 0
                preferredHighlightEnd: grid.cellHeight

                // 跟随模式切换时，高亮实例会被重建
                highlight: followsCheck.checked ? managedHighlight : springHighlight

                delegate: Item {
                    required property int index

                    width: grid.cellWidth
                    height: grid.cellHeight

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 5
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

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            grid.currentIndex = index
                            grid.forceActiveFocus()
                        }
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            text: "共 %1 项 ｜ currentIndex：%2 ｜ 点击或方向键切换".arg(grid.count).arg(grid.currentIndex)
            font.pointSize: 10
            color: "#666"
            elide: Text.ElideRight
        }
    }

    // 交给视图管理几何的高亮
    Component {
        id: managedHighlight
        Rectangle {
            color: "#1296FF"
            radius: 10
            opacity: 0.25
        }
    }

    // 自行管理几何与移动的高亮
    Component {
        id: springHighlight
        Rectangle {
            color: "#1296FF"
            radius: 10
            opacity: 0.25
            width: grid.cellWidth
            height: grid.cellHeight
            x: grid.currentItem ? grid.currentItem.x : 0
            y: grid.currentItem ? grid.currentItem.y : 0

            Behavior on x { SpringAnimation { spring: 3; damping: 0.2 } }
            Behavior on y { SpringAnimation { spring: 3; damping: 0.2 } }
        }
    }
}
