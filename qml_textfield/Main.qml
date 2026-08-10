import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 720
    height: 480
    title: "TextField Demo"
    color: "#FFF"

    // 顶部标题栏
    header: ToolBar {
        implicitHeight: 50
        leftPadding: 20
        background: Rectangle {
            color: "#1296FF"
        }
        Label {
            text: "TextField Demo"
            color: "white"
            font.pointSize: 14
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // 底部状态栏
    footer: ToolBar {
        background: Rectangle { color: "#f5f5f5"; border.color: "#ddd"; border.width: 1 }
        Label {
            text: "Qt6 QML示例"
            color: "#666"
            font.pointSize: 10
            anchors.centerIn: parent
        }
    }

    RowLayout {
        spacing: 0
        anchors.fill: parent

        // 左侧导航栏
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
                ListElement { name: "基础示例"; category: "TextField基础"; source: "Demo_TextFieldBase.qml" }
                ListElement { name: "输入限制"; category: "TextField基础"; source: "Demo_TextFieldInputLimit.qml" }

                ListElement { name: "年龄校验"; category: "TextField校验"; source: "Demo_TextFieldAgeValidator.qml" }
                ListElement { name: "邮箱格式校验"; category: "TextField校验"; source: "Demo_TextFieldEmailValidator.qml" }
                ListElement { name: "手机号校验"; category: "TextField校验"; source: "Demo_TextFieldPhoneValidator.qml" }
                ListElement { name: "掩码与日期校验"; category: "TextField校验"; source: "Demo_TextFieldInputMask.qml" }
                ListElement { name: "IP地址校验"; category: "TextField校验"; source: "Demo_TextFieldIpValidator.qml" }
                ListElement { name: "身份证校验"; category: "TextField校验"; source: "Demo_TextFieldIdCardValidator.qml" }

                ListElement { name: "自定义文本框"; category: "TextField样式"; source: "Demo_TextFieldCustom.qml" }
                ListElement { name: "带图标的文本框"; category: "TextField样式"; source: "Demo_TextFieldIcon.qml" }
                ListElement { name: "带删除的文本框"; category: "TextField样式"; source: "Demo_TextFieldClearable.qml" }
                ListElement { name: "主题切换"; category: "TextField样式"; source: "Demo_TextFieldMultipleTopic.qml" }

                ListElement { name: "自动关联"; category: "TextField应用"; source: "Demo_TextFieldAutoMatch.qml" }
                ListElement { name: "表单提交"; category: "TextField应用"; source: "Demo_TextFieldFormSubmission.qml" }
            }

            delegate: Rectangle {
                width: parent ? parent.width : 170
                height: 40
                color: ListView.isCurrentItem ? "#BCE6FF" : "#FFF"
                border.width: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        parent.ListView.view.currentIndex = index
                        pageLoader.source = model.source
                    }
                }

                Text {
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: ListView.isCurrentItem ? "#1296FF" : "#333"
                    font.pointSize: 11
                    font.bold: true
                }
            }
        }

        // 导航与内容之间的分隔线
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
