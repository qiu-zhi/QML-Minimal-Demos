import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

TextField {
    id: control
    
    // 自定义属性
    property string leftIcon: ""  // 左侧图标路径
    property string rightIcon: "" // 右侧图标路径
    property bool showClearButton: true // 是否显示清除按钮
    property color accentColor: "#2196F3" // 主题色
    property color borderNormalColor: "#BBDEFB" // 普通状态边框色
    
    // 信号
    signal rightIconClicked()
    
    leftPadding: leftIcon ? 40 : 10
    rightPadding: (rightIcon || showClearButton) ? 40 : 10
    verticalAlignment: Text.AlignVCenter
    font.pixelSize: 14
    selectByMouse: true
    
    // 设置默认的隐式大小
    implicitWidth: 200
    implicitHeight: 30

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 30
        color: control.enabled ? "white" : "#F5F5F5"
        border.width: control.activeFocus ? 2 : 1
        border.color: control.activeFocus ? control.accentColor : control.borderNormalColor
        radius: 4
    }

    // 左侧图标
    Item {
        id: leftIconItem
        parent: control
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 20
        height: 20
        visible: control.leftIcon !== ""

        Image {
            id: leftImage
            source: control.leftIcon
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }

    // 右侧图标或清除按钮
    Item {
        id: rightIconItem
        parent: control
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 20
        height: 20
        visible: showClearButton ? control.text.length > 0 : control.rightIcon !== ""

        Image {
            id: rightImage
            source: control.rightIcon || (showClearButton ? "qrc:/icons/clear.png" : "")
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            id: rightMouseArea
            anchors.fill: parent
            onClicked: {
                if (showClearButton && control.text.length > 0) {
                    control.rightIconClicked()
                    control.text = ""
                } else if (control.rightIcon !== "") {
                    control.rightIconClicked()
                }
            }
            cursorShape: Qt.PointingHandCursor
        }
    }
} 
