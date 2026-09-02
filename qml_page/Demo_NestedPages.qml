import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Page 嵌套结构"
            description: "Page 可嵌套使用，内层 Page 独立管理自己的 header 和 footer"
        }

        Page {
            id: outerPage
            Layout.fillWidth: true
            Layout.fillHeight: true

            header: ToolBar {
                Label {
                    text: "外层 Page"
                    anchors.centerIn: parent
                }
            }

            Page {
                id: innerPage
                anchors.fill: parent
                anchors.margins: 10

                header: Rectangle {
                    height: 30
                    color: "#3498db"
                    radius: 4

                    Text {
                        text: "内层 Page Header"
                        anchors.centerIn: parent
                        color: "#fff"
                    }
                }

                footer: Rectangle {
                    height: 25
                    color: "#e74c3c"
                    radius: 4

                    Text {
                        text: "内层 Page Footer"
                        anchors.centerIn: parent
                        color: "#fff"
                        font.pointSize: 10
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: "#f0f0f0"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "内层 Page 内容区域"
                        font.pointSize: 12
                        color: "#333"
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
