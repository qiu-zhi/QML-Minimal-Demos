pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    id: root
    property color mainColor: Theme.listColors[Theme.demo1]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            color: Theme.demoStyle.frameBg
            radius: 6
            border.color: Theme.demoStyle.frameBorder
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Text {
                    text: "当前方向:"
                    font.pointSize: 10
                    color: Theme.demoStyle.frameText
                }

                Text {
                    text: splitView.orientation === Qt.Horizontal ? "水平" : "垂直"
                    font.pointSize: 10
                    color: root.mainColor
                    font.bold: true
                }

                Item { Layout.fillWidth: true }

                CustomButton {
                    text: "切换方向"
                    onClicked: {
                        if (splitView.orientation === Qt.Horizontal) {
                            splitView.orientation = Qt.Vertical
                        } else {
                            splitView.orientation = Qt.Horizontal
                        }
                    }
                }
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
                    implicitWidth: 6
                    implicitHeight: 6
                    color: root.mainColor
                    opacity: SplitHandle.pressed ? 1.0 : 0.7
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
