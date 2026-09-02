import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "自定义格式"
            description: "使用 toLocaleString(locale, format) 以自定义格式字符串输出日期"
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
                    text: "中文格式:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale(), "yyyy年MM月dd日 hh时mm分ss秒")
                    font.pixelSize: 13
                    color: "#333"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "星期+日期:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale(), "ddd yyyy-MM-dd")
                    font.pixelSize: 13
                    color: "#333"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "完整星期:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale(), "dddd yyyy年MM月dd日")
                    font.pixelSize: 13
                    color: "#333"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "ISO格式:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale(), "yyyy-MM-ddTHH:mm:ss")
                    font.pixelSize: 13
                    color: "#333"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "上下午:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale(), "yyyy-MM-dd hh:mm AP")
                    font.pixelSize: 13
                    color: "#333"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
