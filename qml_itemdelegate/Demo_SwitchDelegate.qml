import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "SwitchDelegate 开关列表项"
            description: "开关委托组件，提供开关切换功能，常用于系统设置项的开关列表"
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
                spacing: 2
                ScrollBar.vertical: ScrollBar {}

                model: ListModel {
                    ListElement { label: "飞行模式";     isOn: false }
                    ListElement { label: "Wi-Fi";        isOn: true }
                    ListElement { label: "蓝牙";         isOn: true }
                    ListElement { label: "移动数据";     isOn: true }
                    ListElement { label: "定位服务";     isOn: false }
                    ListElement { label: "护眼模式";     isOn: false }
                    ListElement { label: "深色模式";     isOn: false }
                    ListElement { label: "自动旋转";     isOn: true }
                    ListElement { label: "省电模式";     isOn: false }
                }

                delegate: SwitchDelegate {
                    id: switchItem
                    required property string label
                    required property bool isOn

                    width: ListView.view.width
                    height: 44
                    checked: isOn

                    // 指示器移到最左侧，文本紧随其后；右侧留白，滚动条不再遮挡交互区
                    indicator: Item {} // 屏蔽默认的右侧开关

                    contentItem: RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 6
                        spacing: 10

                        // 自绘开关：轨道 + 滑块（checked 时滑块右移）
                        Rectangle {
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 22
                            Layout.alignment: Qt.AlignVCenter
                            radius: height / 2
                            color: switchItem.checked ? "#1976D2" : "#cfd6df"
                            Behavior on color { ColorAnimation { duration: 150 } }

                            Rectangle {
                                width: 18
                                height: 18
                                radius: width / 2
                                y: (parent.height - height) / 2
                                x: switchItem.checked ? parent.width - width - 2 : 2
                                color: "white"
                                Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
                            }
                        }

                        Text {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            text: switchItem.label
                            elide: Text.ElideRight
                            font.pointSize: 11
                            color: "#333"
                        }
                    }
                }
            }
        }
    }
}
