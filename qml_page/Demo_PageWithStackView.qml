pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Page 与 StackView"
            description: "StackView 以栈方式管理 Page：push 压入新页、pop 弹出返回，每页是带独立 header 的 Page"
        }

        StackView {
            id: stackView
            Layout.fillWidth: true
            Layout.fillHeight: true
            // push/pop 过渡动画会滑动页面，需裁剪防止越界绘制到容器外
            clip: true
            initialItem: pageHome
        }

        // 栈深：当前栈中 Page 的层数，随 push/pop 实时变化
        Label {
            text: "栈深 depth = " + stackView.depth
            font.pointSize: 10
            color: "#666"
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // 页面 1：首页（initialItem，无返回按钮）
    Component {
        id: pageHome

        Page {
            header: ToolBar {
                Label {
                    text: "首页"
                    anchors.centerIn: parent
                    font.bold: true
                }
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 12

                Label {
                    text: "第 1 层页面"
                    font.pointSize: 14
                }
                Label {
                    text: "StackView 中的每一页都是一个独立的 Page"
                    color: "#666"
                }
                Button {
                    Layout.fillWidth: true
                    text: "push 进入第 2 层"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: stackView.push(pageDetail)
                }
            }
        }
    }

    // 页面 2：详情页（由首页 push 进入，header 带返回按钮）
    Component {
        id: pageDetail

        Page {
            header: ToolBar {
                ToolButton {
                    text: "‹ 返回"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: stackView.pop()
                }
                Label {
                    text: "详情页"
                    anchors.centerIn: parent
                    font.bold: true
                }
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 12

                Label {
                    text: "第 2 层页面"
                    font.pointSize: 14
                }
                Label {
                    text: "header 的返回按钮调用 stackView.pop()"
                    color: "#666"
                }
            }
        }
    }
}
