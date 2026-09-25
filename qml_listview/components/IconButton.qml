import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    
    // 公共属性
    property string iconSource: ""  // 图标源
    property string text: ""        // 按钮文本
    property int iconSize: 20      // 图标大小
    property real opacityNormal: 1.0  // 正常状态透明度
    property real opacityHovered: 0.7  // 悬停状态透明度
    property color textColor: "black" // 文本颜色
    property int fontSize: 14          // 文本大小
    property bool enabled: true       // 按钮是否启用
    
    // 边框和背景属性
    property bool showBorder: false   // 是否显示边框
    property color borderColor: "#CCCCCC"  // 边框颜色
    property int borderWidth: 1       // 边框宽度
    property bool showBackground: false  // 是否显示背景
    property color backgroundColor: "#FFFFFF"  // 背景颜色
    
    // 信号
    signal clicked()
    
    // 设置默认大小
    implicitWidth: content.width + (showBackground ? 20 : 0)  // 有背景时增加内边距
    implicitHeight: content.height + (showBackground ? 10 : 0)
    
    // 背景矩形
    Rectangle {
        id: background
        anchors.fill: parent
        color: root.backgroundColor
        visible: root.showBackground
        border.width: root.showBorder ? root.borderWidth : 0
        border.color: root.borderColor
        radius: 4  // 添加圆角效果
    }
    
    // 内容布局
    RowLayout {
        id: content
        spacing: text ? 5 : 0  // 如果有文本则添加间距
        anchors.centerIn: parent  // 内容居中对齐
        
        // 图标
        Image {
            id: icon
            source: root.iconSource
            width: root.iconSize
            height: root.iconSize
            visible: root.iconSource !== ""
            opacity: mouseArea.containsMouse ? root.opacityHovered : root.opacityNormal
            enabled: root.enabled
        }
        
        // 文本
        Text {
            id: label
            text: root.text
            color: root.textColor
            font.pixelSize: root.fontSize
            visible: root.text !== ""
            opacity: mouseArea.containsMouse ? root.opacityHovered : root.opacityNormal
            enabled: root.enabled
        }
    }
    
    // 鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (root.enabled) {
                root.clicked()
            }
        }
    }
    
    // 禁用状态的视觉效果
    states: State {
        name: "disabled"
        when: !root.enabled
        PropertyChanges {
            target: content
            opacity: 0.5
        }
    }
} 