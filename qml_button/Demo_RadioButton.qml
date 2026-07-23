import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "RadioButton - 单选按钮"
            description: "单选框，同一布局内自动互斥"
        }

        RadioButton {
            text: "在布局外-单选按钮"
            Layout.alignment: Qt.AlignLeft
            onClicked: {
                textResult.text = "在同一布局内的按钮才能进行单选";
            }
        }

        // 在同一布局内的按钮才能进行单选
        Column {
            id: childColumn
            Layout.leftMargin: 15
            Layout.alignment: Qt.AlignLeft
            spacing: 15

            RadioButton {
                text: "在布局内-单选按钮1"
                onClicked: {
                    textResult.text = "点击了" + text;
                }
            }
            RadioButton {
                text: "在布局内-单选按钮2"
                onClicked: {
                    textResult.text = "点击了" + text;
                }
            }
        }

        Text {
            id: textResult
            Layout.alignment: Qt.AlignLeft
        }

        Item { Layout.fillHeight: true }
    }
}
