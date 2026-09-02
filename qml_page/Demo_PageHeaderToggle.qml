import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Page 动态显隐"
            description: "header/footer 可随时隐藏，内容区会自动伸缩占满剩余空间（implicitHeaderHeight 会随可见性变化）"
        }

        Page {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // header/footer 的可见性由下方两个开关控制
            header: ToolBar {
                visible: headerSwitch.checked
                Label {
                    text: "Header 区域"
                    anchors.centerIn: parent
                }
            }

            footer: ToolBar {
                visible: footerSwitch.checked
                Label {
                    text: "Footer 区域"
                    anchors.centerIn: parent
                }
            }

            // 直接子项自动放入 contentItem，随 header/footer 显隐自动伸缩
            Rectangle {
                anchors.fill: parent
                color: "#f5f5f5"

                Label {
                    anchors.centerIn: parent
                    text: "内容区自动占满剩余空间"
                    color: "#666"
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Label { text: "Header"; font.pointSize: 11 }
            Switch {
                id: headerSwitch
                checked: true
            }
            Item { Layout.fillWidth: true }
            Label { text: "Footer"; font.pointSize: 11 }
            Switch {
                id: footerSwitch
                checked: true
            }
        }

        Item { Layout.fillHeight: true }
    }
}
