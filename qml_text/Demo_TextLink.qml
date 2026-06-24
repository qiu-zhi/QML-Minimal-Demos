import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 链接交互"
            description: "演示链接交互功能：点击打开外部链接、linkActivated 信号、hoveredLink 属性"
        }

        ColumnLayout {
            Layout.leftMargin: 20
            spacing: 12

            Text {
                text: '点击访问 <a href="https://qt.io">Qt 官网</a>'
                textFormat: Text.RichText
                font.pointSize: 12
                linkColor: "#1976D2"
                onLinkActivated: (link) => {
                    Qt.openUrlExternally(link)
                }
            }

            Text {
                text: '点击打开 <a href="https://doc.qt.io/qt-6/qml-qtquick-text.html">Text 文档</a>'
                textFormat: Text.RichText
                font.pointSize: 12
                linkColor: "#1976D2"
                onLinkActivated: (link) => {
                    Qt.openUrlExternally(link)
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#eee"
            }

            Text {
                text: "实现: Text + textFormat: Text.RichText + onLinkActivated"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "点击链接会调用 Qt.openUrlExternally() 打开浏览器"
                font.pointSize: 9
                color: "#666"
            }
        }

        Item { Layout.fillHeight: true }
    }
}
