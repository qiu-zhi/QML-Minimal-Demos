import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 链接交互"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Text {
                id: linkText
                text: "点击访问 <a href='https://qt.io'>Qt官网</a>"
                textFormat: Text.RichText
                font.pointSize: 12
                linkColor: "#1976D2"
                onLinkActivated: (link) => {
                    linkStatus.text = "已点击: " + link
                }
                onLinkHovered: (link) => {
                    linkStatus.text = "悬停: " + link
                }
            }

            Text {
                id: linkStatus
                text: "状态: 无"
                font.pointSize: 10
                color: "#666"
            }

            Text {
                text: "hoveredLink: " + linkText.hoveredLink
                font.pointSize: 10
                color: "#666"
            }

            Rectangle {
                width: 200
                height: 1
                color: "#eee"
            }

            Text {
                text: "信号: linkActivated, linkHovered"
                font.pointSize: 9
                color: "#666"
            }

            Text {
                text: "属性: hoveredLink, linkAt(x,y)"
                font.pointSize: 9
                color: "#666"
            }
        }
    }
}
