import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qml_styles

ApplicationWindow {
    visible: true
    width: 720
    height: 480
    title: "Controls 样式与主题"

    header: Rectangle {
        implicitHeight: 50
        color: "#1296FF"

        Text {
            x: 20
            anchors.verticalCenter: parent.verticalCenter
            text: "Controls 样式与主题：" + (StyleHelper.currentStyle.length > 0
                                              ? StyleHelper.currentStyle : "平台默认")
            color: "white"
            font.pointSize: 14
            font.bold: true
        }
    }

    RowLayout {
        spacing: 0
        anchors.fill: parent

        ListView {
            id: navList
            Layout.preferredWidth: 170
            Layout.fillHeight: true
            clip: true
            section.property: "category"
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                width: parent ? parent.width : 170
                height: 35
                color: "#F5F7FA"
                Text {
                    x: 6
                    anchors.verticalCenter: parent.verticalCenter
                    text: section
                    color: "#1296FF"
                    font.pointSize: 12
                    font.bold: true
                }
            }
            model: ListModel {
                ListElement { name: "样式切换"; category: "样式选择"; source: "Demo_StyleSwitcher.qml" }
                ListElement { name: "默认控件"; category: "样式选择"; source: "Demo_StyleControls.qml" }
                ListElement { name: "自定义控件"; category: "样式选择"; source: "Demo_StyleCustom.qml" }
            }

            delegate: Rectangle {
                id: navItem
                readonly property bool isCurrent: ListView.isCurrentItem

                width: parent ? parent.width : 170
                height: 40
                color: isCurrent ? "#BCE6FF" : "#FFF"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        navItem.ListView.view.currentIndex = index
                        pageLoader.source = model.source
                    }
                }

                Text {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: navItem.isCurrent ? "#1296FF" : "#333"
                    font.pointSize: 11
                    font.bold: true
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: "#ddd"
        }

        // 右侧内容区：使用 Loader 延迟加载，只实例化当前页面
        Loader {
            id: pageLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: navList.model.get(0).source
        }
    }
}
