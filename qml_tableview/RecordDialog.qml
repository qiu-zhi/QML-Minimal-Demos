import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 新增 / 修改记录弹窗：只负责界面与输入，数据库操作由页面接信号完成
Dialog {
    id: dialog

    property bool isEdit: false

    signal recordAdded(string name, int age)
    signal recordEdited(string name, int age)

    title: isEdit ? "修改记录" : "新增记录"
    width: 400
    modal: true
    padding: 16
    anchors.centerIn: parent

    function openForAdd() {
        isEdit = false
        nameField.text = ""
        ageField.text = ""
        open()
    }

    function openForEdit(name, age) {
        isEdit = true
        nameField.text = name
        ageField.text = age
        open()
    }

    onAccepted: {
        // 立即提交并刷新由页面处理，这里只上抛输入结果
        if (isEdit)
            recordEdited(nameField.text, parseInt(ageField.text))
        else
            recordAdded(nameField.text, parseInt(ageField.text))
    }

    // 弹窗里的输入框：与其他控件同一套边框色（#e0e0e0，聚焦转 #1296FF）
    component FormField: TextField {
        id: field

        Layout.fillWidth: true
        implicitHeight: 32
        leftPadding: 10
        rightPadding: 10
        color: "#333"
        font.pixelSize: 13
        placeholderTextColor: "#999"
        selectByMouse: true
        verticalAlignment: TextInput.AlignVCenter

        background: Rectangle {
            radius: 4
            color: "white"
            border.width: field.activeFocus ? 2 : 1
            border.color: field.activeFocus ? "#1296FF" : "#e0e0e0"
        }
    }

    // 标题栏：沿用页面标题的「深色粗体 + 蓝色下划线」。
    // Dialog 的 header 默认整宽贴边（Qt 只给 contentItem 留 padding），
    // 所以这里手动按 padding 内缩，让标题、下划线、输入框、按钮距边框的留白完全一致
    header: Item {
        // 上内边距 + 标题行高 + 与下划线的间隔 + 下划线
        implicitHeight: dialog.topPadding + 20 + 10 + 2

        Text {
            x: dialog.leftPadding
            y: dialog.topPadding
            text: dialog.title
            color: "#333"
            font.pixelSize: 15
            font.bold: true
        }

        Rectangle {
            anchors.bottom: parent.bottom
            x: dialog.leftPadding
            width: parent.width - dialog.leftPadding - dialog.rightPadding
            height: 2
            color: "#1296FF"
        }
    }

    background: Rectangle {
        radius: 8
        color: "white"
        border.color: "#e0e0e0"
    }

    // 内容用 implicitHeight 撑开弹窗；不要写 anchors.fill: parent，
    // 那会让弹窗失去自身尺寸，输入框被压成一条线
    contentItem: ColumnLayout {
        spacing: 12

        FormField {
            id: nameField
            placeholderText: "请输入姓名"
            onAccepted: dialog.accept()
        }

        FormField {
            id: ageField
            placeholderText: "请输入年龄"
            validator: IntValidator { bottom: 0; top: 200 }
            onAccepted: dialog.accept()
        }
    }

    // 按钮自绘：不依赖平台样式（原生样式的标准按钮在不同系统上外观差异很大）。
    // footer 默认上下左右都贴边，四周手动留出 padding，底部不与弹窗边框贴死
    footer: Item {
        implicitHeight: 32 + dialog.bottomPadding

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: dialog.leftPadding
            anchors.rightMargin: dialog.rightPadding
            anchors.bottomMargin: dialog.bottomPadding
            spacing: 8

            Item { Layout.fillWidth: true }

            Button {
                id: cancelButton
                text: "取消"
                implicitWidth: 80
                implicitHeight: 32
                onClicked: dialog.reject()

                background: Rectangle {
                    radius: 4
                    color: cancelButton.hovered ? "#eaeaea" : "#f5f5f5"
                    border.color: "#e0e0e0"
                }

                contentItem: Text {
                    text: cancelButton.text
                    color: "#333"
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                id: okButton
                text: isEdit ? "保存" : "确定"
                implicitWidth: 80
                implicitHeight: 32
                onClicked: dialog.accept()

                background: Rectangle {
                    radius: 4
                    color: okButton.hovered ? Qt.darker("#1296FF", 1.15) : "#1296FF"
                }

                contentItem: Text {
                    text: okButton.text
                    color: "white"
                    font.bold: true
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
