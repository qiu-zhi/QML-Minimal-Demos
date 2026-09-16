import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        TitleSeparator {
            title: "索引条件"
            description: "通过 DelegateChoice 的 index 属性为指定位置的条目套用特殊委托，未声明 index 的 DelegateChoice 作为兜底通用委托"
        }

        // 内容区：垂直方向填满剩余空间
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1

            ListView {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8
                clip: true
                ScrollBar.vertical: ScrollBar {}

                model: ListModel {
                    ListElement { value: 100; description: "特殊项目" }
                    ListElement { value: 200; description: "常规项目" }
                    ListElement { value: 300; description: "常规项目" }
                    ListElement { value: 400; description: "常规项目" }
                }

                delegate: DelegateChooser {
                    DelegateChoice {
                        index: 0
                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 60
                            color: "#2196F3"
                            radius: 8

                            Text {
                                anchors.centerIn: parent
                                text: model.description
                                color: "white"
                                font {
                                    bold: true
                                    pixelSize: 16
                                }
                            }
                        }
                    }

                    DelegateChoice {
                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 46
                            color: "white"
                            radius: 6
                            border.color: "#e0e0e0"
                            border.width: 1

                            RowLayout {
                                anchors {
                                    fill: parent
                                    margins: 10
                                }
                                spacing: 10

                                Text {
                                    text: model.description
                                    font.pixelSize: 14
                                    Layout.fillWidth: true
                                }
                                Text {
                                    text: model.value
                                    font {
                                        pixelSize: 14
                                        bold: true
                                    }
                                    color: "#1976D2"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
