import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    QtObject {
        id: nav
        property int currentIndex: 0
        property var pages: [
            { name: "首页", color: "#3498db" },
            { name: "文件", color: "#9b59b6" },
            { name: "设置", color: "#e67e22" }
        ]
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "顶部导航栏"
            description: "顶部水平导航，配合上一页/下一页按钮和 StackView 切换页面"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "<<"
                enabled: nav.currentIndex > 0
                onClicked: {
                    nav.currentIndex--
                    stackView.pop()
                }
            }

            Text {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: nav.pages[nav.currentIndex].name
                font.pointSize: 10
            }

            Button {
                text: ">>"
                enabled: nav.currentIndex < nav.pages.length - 1
                onClicked: {
                    nav.currentIndex++
                    // 页面索引通过参数注入：若让每个页面都绑定 nav.currentIndex，
                    // 切换时栈内所有页面会一起变色。
                    stackView.push(pageComponent, { "idx": nav.currentIndex })
                }
            }
        }

        StackView {
            id: stackView
            Layout.fillWidth: true
            Layout.fillHeight: true
            // 转场时页面从边界外滑入，必须裁剪，否则会溢出到左侧导航栏
            clip: true
            initialItem: pageComponent

            pushEnter: Transition {
                PropertyAnimation {
                    property: "x"
                    from: stackView.width
                    to: 0
                    duration: 200
                }

                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }
            }

            pushExit: Transition {
                PropertyAnimation {
                    property: "x"
                    from: 0
                    to: -stackView.width
                    duration: 200
                }

                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 200
                }
            }

            popEnter: Transition {
                PropertyAnimation {
                    property: "x"
                    from: -stackView.width
                    to: 0
                    duration: 200
                }

                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }
            }

            popExit: Transition {
                PropertyAnimation {
                    property: "x"
                    from: 0
                    to: stackView.width
                    duration: 200
                }

                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 200
                }
            }
        }
    }

    Component {
        id: pageComponent

        Rectangle {
            id: pageRect
            property int idx: 0

            color: nav.pages[pageRect.idx].color
            radius: 4

            Text {
                anchors.centerIn: parent
                text: nav.pages[pageRect.idx].name + "内容"
                color: "#fff"
                font.pointSize: 12
                font.bold: true
            }
        }
    }
}
