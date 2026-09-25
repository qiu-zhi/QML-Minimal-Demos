pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root
    property color mainColor: Theme.listColors[Theme.demo3]

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
                    text: "布局结构:"
                    font.pointSize: 10
                    color: Theme.demoStyle.frameText
                }

                Text {
                    text: "左侧面板 + 右侧(上下面板)"
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
                id: horizontalSplit
                anchors.fill: parent
                anchors.margins: 10
                orientation: Qt.Horizontal

                handle: Rectangle {
                    implicitWidth: 6
                    implicitHeight: 6
                    color: root.mainColor
                    opacity: SplitHandle.pressed ? 1.0 : 0.7
                }

                // 面板1
                CustomRect {
                    SplitView.minimumWidth: 60
                    SplitView.minimumHeight: 60
                    rectColor: Qt.color(root.mainColor).darker(1.0)
                    rectNum: "1"
                }

                SplitView {
                    id: verticalSplit
                    SplitView.fillWidth: true
                    SplitView.fillHeight: true
                    SplitView.minimumWidth: 80
                    SplitView.minimumHeight: 80
                    orientation: Qt.Vertical

                    handle: Rectangle {
                        implicitWidth: 6
                        implicitHeight: 6
                        color: root.mainColor
                        opacity: SplitHandle.pressed ? 1.0 : 0.7
                    }

                    // 面板2
                    CustomRect {
                        SplitView.minimumWidth: 80
                        SplitView.minimumHeight: 80
                        rectColor: Qt.color(root.mainColor).darker(1.2)
                        rectNum: "2"
                    }

                    // 面板3
                    CustomRect {
                        SplitView.minimumWidth: 80
                        SplitView.minimumHeight: 80
                        rectColor: Qt.color(root.mainColor).darker(1.4)
                        rectNum: "3"
                    }
                }
            }
        }
    }
}
