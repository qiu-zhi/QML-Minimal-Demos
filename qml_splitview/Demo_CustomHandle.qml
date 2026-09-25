pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root
    property color mainColor: Theme.listColors[Theme.demo2]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            color: Theme.demoStyle.frameBg
            radius: 6
            border.color: Theme.demoStyle.frameBorder
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Text {
                    text: "Handle样式:"
                    font.pointSize: 10
                    color: Theme.demoStyle.frameText
                }

                Text {
                    text: "渐变色 + 圆角"
                    font.pointSize: 10
                    color: root.mainColor
                    font.bold: true
                }

                Item { Layout.fillWidth: true }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Theme.demoStyle.frameBg
            border.color: Theme.demoStyle.frameBorder
            border.width: 1
            radius: 6

            SplitView {
                id: splitView
                anchors.fill: parent
                anchors.margins: 10
                orientation: Qt.Horizontal

                handle: Rectangle {
                    id: handle
                    implicitWidth: 8
                    implicitHeight: 8
                    radius: 4

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: root.mainColor }
                        GradientStop { position: 0.5; color: Qt.color(root.mainColor).darker(1.2) }
                        GradientStop { position: 1.0; color: root.mainColor }
                    }

                    opacity: splitView.resizing ? 1.0 : 0.3

                    // handle正中间
                    Rectangle {
                        width: splitView.orientation === Qt.Horizontal ? parent.width - 4 : 30
                        height: splitView.orientation === Qt.Horizontal ? 30 : parent.height - 4
                        radius: 4
                        color: Theme.demoStyle.handle
                        anchors.centerIn: parent
                    }
                }

                // 面板1
                CustomRect {
                    SplitView.minimumWidth: 80
                    SplitView.minimumHeight: 80
                    rectColor: Qt.color(root.mainColor).darker(1.0)
                    rectNum: "1"
                }

                // 面板2
                CustomRect {
                    SplitView.minimumWidth: 80
                    SplitView.minimumHeight: 80
                    rectColor: Qt.color(root.mainColor).darker(1.2)
                    rectNum: "2"
                }
            }
        }
    }
}
