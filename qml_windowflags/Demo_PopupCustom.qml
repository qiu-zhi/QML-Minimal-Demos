import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义弹窗"
            description: "通过 background 和 contentItem 完全自定义弹窗样式"
        }

        Button {
            text: "打开自定义弹窗"
            Layout.preferredWidth: 150
            Layout.preferredHeight: 40
            onClicked: customPopup.open()
        }

        Item { Layout.fillHeight: true }
    }

    Popup {
        id: customPopup
        parent: Overlay.overlay
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 300
        height: 200
        modal: true
        closePolicy: Popup.CloseOnEscape

        background: Rectangle {
            color: "#BCE6FF"
            radius: 12
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            Text {
                text: "自定义样式弹窗"
                font.pointSize: 14
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "通过 background 属性\n可以完全自定义弹窗背景样式"
                font.pointSize: 11
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                text: "关闭"
                Layout.preferredWidth: 100
                Layout.preferredHeight: 35
                Layout.alignment: Qt.AlignHCenter
                onClicked: customPopup.close()
            }
        }
    }
}
