import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "日期格式化"
            description: "使用 Qt.locale() 和 Locale 格式常量显示不同格式的日期和时间"
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
                    text: "日期（长格式）:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleDateString(Qt.locale(), Locale.LongFormat)
                    font.pixelSize: 13
                    color: "#333"
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "日期（短格式）:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleDateString(Qt.locale(), Locale.ShortFormat)
                    font.pixelSize: 13
                    color: "#333"
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "时间（长格式）:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleTimeString(Qt.locale(), Locale.LongFormat)
                    font.pixelSize: 13
                    color: "#333"
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "时间（短格式）:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
                    font.pixelSize: 13
                    color: "#333"
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Text {
                    text: "日期+时间（默认）:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property date d: new Date()
                    text: d.toLocaleString(Qt.locale())
                    font.pixelSize: 13
                    color: "#333"
                    lineHeight: 1.5
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
