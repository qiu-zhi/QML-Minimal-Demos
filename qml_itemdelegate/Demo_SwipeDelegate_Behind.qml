import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "SwipeDelegate 滑动露出背景"
            description: "滑动委托的 behind 属性：滑动时显示位于 contentItem 和 background 后方的组件，左右滑效果一致"
        }

        // 内容卡片：列表垂直方向铺满剩余空间
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ListView {
                id: listView
                anchors.fill: parent
                anchors.margins: 8
                clip: true
                spacing: 4
                ScrollBar.vertical: ScrollBar {}

                model: 8
                delegate: SwipeDelegate {
                    required property int index

                    text: "选项 " + (index + 1)
                    width: ListView.view.width
                    height: 46

                    // 注意：behind 不能与 left / right 同时使用
                    // 无论向左还是向右滑动，都露出同一块位于后方的组件
                    swipe.behind: Label {
                        text: "behind"
                        color: "#fff"
                        font.bold: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        width: parent.width
                        height: parent.height

                        background: Rectangle {
                            color: "#1296FF"
                        }
                    }
                }
            }
        }
    }
}
