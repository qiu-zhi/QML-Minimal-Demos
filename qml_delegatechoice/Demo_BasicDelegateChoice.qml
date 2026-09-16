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
            title: "基本用法"
            description: "通过 role 属性指定匹配的模型角色，按 type 取值将图片行与文本行分发给不同的委托渲染"
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
                    ListElement { type: "image"; source: "qrc:/qt_logo.png" }
                    ListElement { type: "text"; content: "这是一段文本内容"; color: "blue" }
                    ListElement { type: "image"; source: "qrc:/qt_logo.png" }
                    ListElement { type: "text"; content: "又是一段文本"; color: "red" }
                }

                delegate: DelegateChooser {
                    role: "type"

                    DelegateChoice {
                        roleValue: "image"
                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 76
                            color: "white"
                            radius: 6
                            border.color: "#e0e0e0"
                            border.width: 1

                            Image {
                                anchors.centerIn: parent
                                width: 60
                                height: 60
                                source: model.source
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }

                    DelegateChoice {
                        roleValue: "text"
                        delegate: Rectangle {
                            width: ListView.view.width
                            height: 42
                            color: "white"
                            radius: 6
                            border.color: "#e0e0e0"
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: model.content
                                font.pixelSize: 15
                                color: model.color
                            }
                        }
                    }
                }
            }
        }
    }
}
