import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text vs Label 对比"
            description: "对比 Text 和 Label 组件：字体继承、背景支持、适用场景"
        }

        // 对比卡片
        Rectangle {
            Layout.fillWidth: true
            Layout.topMargin: 5
            Layout.bottomMargin: 5
            color: "#f8f9fa"
            border.color: "#e0e0e0"
            border.width: 1
            radius: 8
            implicitHeight: compareRow.implicitHeight + 40

            RowLayout {
                id: compareRow
                anchors.centerIn: parent
                spacing: 30

                // Text组件
                ColumnLayout {
                    spacing: 8
                    Layout.alignment: Qt.AlignHCenter

                    Text {
                        text: "Text"
                        font.pointSize: 14
                        font.bold: true
                        color: "#1976D2"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: "手动设置字体"
                        font.pointSize: 11
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: "不支持背景"
                        font.pointSize: 11
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: "适合: 文本展示"
                        font.pointSize: 11
                        color: "#666"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                Rectangle {
                    width: 1
                    Layout.fillHeight: true
                    color: "#ccc"
                }

                // Label组件
                ColumnLayout {
                    spacing: 8
                    Layout.alignment: Qt.AlignHCenter

                    Text {
                        text: "Label"
                        font.pointSize: 14
                        font.bold: true
                        color: "#E91E63"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: "继承应用字体"
                        font.pointSize: 11
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: "支持背景"
                        font.pointSize: 11
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        text: "适合: 表单设置"
                        font.pointSize: 11
                        color: "#666"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }

        Note {
            text: "**选择建议：**\n\n- 简单文本展示 → Text\n- 需要背景 / 表单场景 → Label\n- 与控件配合 → Label"
        }
    }
}
