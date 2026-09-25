pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root
    property color mainColor: Theme.listColors[Theme.demo4]

    property var savedState: null
    property bool hasSavedState: false
    property bool splitChanged: false

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
                    text: "状态:"
                    font.pointSize: 10
                    color: Theme.demoStyle.frameText
                }

                // 显示保存状态
                Text {
                    text: root.hasSavedState ? "已保存" : "未保存"
                    font.pointSize: 10
                    font.bold: true
                    color: root.mainColor
                }

                Item {
                    Layout.fillWidth: true
                }

                // 在移动splitview时，状态闪烁
                Text {
                    text: "Resizing"
                    font.pointSize: 10
                    font.bold: true
                    color: root.mainColor
                    visible: splitView.resizing

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        running: splitView.resizing
                        NumberAnimation { to: 0.3; duration: 500 }
                        NumberAnimation { to: 1.0; duration: 500 }
                    }
                }

                CustomButton {
                    text: "保存状态"
                    // 解决第一次保存失效的问题，必须先移动splitview
                    enabled: root.splitChanged
                    bgNormal: root.mainColor
                    bgPressed: Qt.color(root.mainColor).darker(1.2)
                    onClicked: {
                        root.savedState = splitView.saveState()
                        root.hasSavedState = true
                        console.log("SplitView状态已保存")
                    }
                }

                CustomButton {
                    text: "恢复状态"
                    enabled: root.hasSavedState
                    bgNormal: root.mainColor
                    bgPressed: Qt.color(root.mainColor).darker(1.2)
                    onClicked: {
                        if (root.savedState) {
                            splitView.restoreState(root.savedState)
                            console.log("SplitView状态已恢复")
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

                onResizingChanged: {
                    root.splitChanged = true
                }

                // 面板1
                CustomRect {
                    SplitView.minimumWidth: 60
                    rectColor: Qt.color(root.mainColor).darker(0.9)
                    rectNum: "1"
                }

                // 面板2
                CustomRect {
                    SplitView.fillWidth: true
                    SplitView.minimumWidth: 60
                    rectColor: Qt.color(root.mainColor).darker(1.1)
                    rectNum: "2"
                }

                // 面板3
                CustomRect {
                    SplitView.minimumWidth: 60
                    rectColor: Qt.color(root.mainColor).darker(1.3)
                    rectNum: "3"
                }
            }
        }
    }
}
