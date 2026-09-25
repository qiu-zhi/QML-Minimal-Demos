pragma Singleton
import QtQuick

QtObject {

    component ButtonStyle: QtObject {
        readonly property color bgNormal: "#3498db"
        readonly property color bgPressed: "#2980b9"
        readonly property color bgDisabled: "#bdc3c7"
        readonly property color textNormal: "#fff"
        readonly property color borderColor: "#ccc"
    }

    component RectNumStyle: QtObject {
        readonly property color bg: "#fff"
        readonly property color rectColor: "#3498db"
        readonly property color numColor: "#fff"
        readonly property color textColor: "#333"
    }

    component DemoStyle: QtObject {
        readonly property color bg: "#f5f5f5"
        readonly property color title: "#333"
        readonly property color frameBg: "#fff"
        readonly property color frameBorder: "#ccc"
        readonly property color frameText: "#666"
        readonly property color handle: "#ccc"
    }

    // 按钮颜色主题
    readonly property ButtonStyle buttonStyle: ButtonStyle {}

    // 标号主题
    readonly property RectNumStyle rectNumStyle: RectNumStyle {}

    // 示例面板主题
    readonly property DemoStyle demoStyle: DemoStyle {}

    // 示例颜色主题
    readonly property var listColors: ["#3498db", "#9b59b6", "#e67e22", "#27ae60"]
    readonly property int demo1: 0
    readonly property int demo2: 1
    readonly property int demo3: 2
    readonly property int demo4: 3
}
