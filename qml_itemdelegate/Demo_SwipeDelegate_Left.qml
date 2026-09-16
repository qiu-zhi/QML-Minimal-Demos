import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "SwipeDelegate 左右滑动操作"
            description: "可左右滑动的委托：左滑露出「归档」，右滑露出「删除」，删除带收起动画"
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

                model: ListModel {
                    ListElement { title: "选项 1"; msg: "已归档" }
                    ListElement { title: "选项 2"; msg: "已归档" }
                    ListElement { title: "选项 3"; msg: "已归档" }
                    ListElement { title: "选项 4"; msg: "已归档" }
                    ListElement { title: "选项 5"; msg: "已归档" }
                    ListElement { title: "选项 6"; msg: "已归档" }
                    ListElement { title: "选项 7"; msg: "已归档" }
                }

                delegate: SwipeDelegate {
                    id: swipeDelegate
                    required property string title
                    required property string msg
                    required property int index

                    text: title
                    width: listView.width
                    height: 46
                    // 裁剪移出界外的文本，避免左滑时文字残留在可视区
                    clip: true

                    // 删除行前先收起，再真正从 model 移除
                    SequentialAnimation {
                        id: seqAnimation
                        PropertyAction { target: swipeDelegate; property: "ListView.delayRemove"; value: true }
                        NumberAnimation { target: swipeDelegate; property: "height"; to: 0; duration: 250 }
                        PropertyAction { target: swipeDelegate; property: "ListView.delayRemove"; value: false }
                    }

                    ListView.onRemove: seqAnimation.start()

                    swipe.right: Label {
                        id: deleteLabel
                        text: "删除"
                        color: "white"
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        width: 88
                        height: parent.height
                        anchors.right: parent.right
                        SwipeDelegate.onClicked: listView.model.remove(swipeDelegate.index)

                        background: Rectangle {
                            color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("tomato", 1.1) : "tomato"
                        }
                    }

                    swipe.left: Label {
                        id: archiveLabel
                        text: "归档"
                        color: "white"
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        width: 88
                        height: parent.height
                        SwipeDelegate.onClicked: {
                            swipeDelegate.text = swipeDelegate.msg
                            swipeDelegate.swipe.close()
                        }

                        background: Rectangle {
                            color: archiveLabel.SwipeDelegate.pressed ? Qt.darker("green", 1.1) : "green"
                        }
                    }
                }
            }
        }
    }
}
