import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "地区日期"
            description: "使用 Qt.locale(\"地区代码\") 显示不同语言和地区的日期格式"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"

            GridLayout {
                anchors.fill: parent
                anchors.margins: 20
                columns: 2
                columnSpacing: 20
                rowSpacing: 15

                Text {
                    text: "中文 (zh_CN)"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale("zh_CN"))
                    font.pixelSize: 13
                    color: "#333"
                }

                Text {
                    text: "英文 (en_US)"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale("en_US"))
                    font.pixelSize: 13
                    color: "#333"
                }

                Text {
                    text: "德文 (de_DE)"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale("de_DE"))
                    font.pixelSize: 13
                    color: "#333"
                }

                Text {
                    text: "日文 (ja_JP)"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale("ja_JP"))
                    font.pixelSize: 13
                    color: "#333"
                }

                Text {
                    text: "法文 (fr_FR)"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale("fr_FR"))
                    font.pixelSize: 13
                    color: "#333"
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
