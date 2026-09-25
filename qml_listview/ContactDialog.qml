import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./components"

Dialog {
    id: root
    width: 400
    modal: true

    property bool isEdit: false
    property string currentName: ""
    property string currentPhone: ""

    title: isEdit ? "修改联系人" : "添加新联系人"
    closePolicy: Dialog.NoAutoClose

    signal contactConfirmed(string name, string phone)

    function clearInputs() {
        nameField.text = ""
        phoneField.text = ""
    }

    onOpened: {
        if (isEdit) {
            nameField.text = currentName
            phoneField.text = currentPhone
        } else {
            clearInputs()
        }
    }

    onAccepted: {
        if (nameField.text && phoneField.text) {
            contactConfirmed(nameField.text, phoneField.text)
            clearInputs()
        }
    }
    onRejected: clearInputs()

    contentItem: ColumnLayout {
        spacing: 20
        anchors.margins: 10

        CustomTextField {
            id: nameField
            Layout.fillWidth: true
            placeholderText: "姓名"
            leftIcon: "qrc:/icons/user.png"
        }

        CustomTextField {
            id: phoneField
            Layout.fillWidth: true
            placeholderText: "电话"
            leftIcon: "qrc:/icons/phone.png"
            validator: RegularExpressionValidator {
                regularExpression: /^[0-9\+\-\s]*$/
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            spacing: 10

            CustomButton {
                text: isEdit ? qsTr("保存") : qsTr("确定")
                enabled: nameField.text.length > 0 && phoneField.text.length > 0
                onClicked: root.accept()
            }

            CustomButton {
                text: qsTr("取消")
                bgColor: "#f5f5f5"
                textColor: "#333333"
                onClicked: root.reject()
            }
        }
    }
}



