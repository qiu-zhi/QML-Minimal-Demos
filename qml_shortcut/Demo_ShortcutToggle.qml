import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    // 状态属性定义在文件根对象上（QML 作用域规则：子对象无法通过
    // 裸名称访问中间层对象的属性，只能访问文件根对象与 id）。
    property bool darkBackground: false
    property bool blueBorder: false
    property bool thickBorder: false

    // 状态卡片查询函数（供 Repeater 委托调用，保持实时响应）
    function stateOn(i) {
        if (i === 0) return darkBackground
        if (i === 1) return blueBorder
        return thickBorder
    }
    function stateText(i) {
        if (i === 0) return darkBackground ? "深色" : "浅色"
        if (i === 1) return blueBorder ? "蓝色" : "灰色"
        return thickBorder ? "加粗" : "变细"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "状态切换"
            description: "用快捷键直接切换矩形的背景色、边框颜色与粗细等视觉属性"
        }

        // Ctrl+T: 背景色（浅色/深色）
        Shortcut {
            sequence: "Ctrl+T"
            onActivated: {
                darkBackground = !darkBackground
                statusText.text = "Ctrl+T - 背景: " + (darkBackground ? "深色" : "浅色")
            }
        }

        // Ctrl+B: 边框颜色（灰色/蓝色）
        Shortcut {
            sequence: "Ctrl+B"
            onActivated: {
                blueBorder = !blueBorder
                statusText.text = "Ctrl+B - 边框: " + (blueBorder ? "蓝色" : "橙色")
            }
        }

        // Ctrl+S: 边框粗细（细/粗）
        Shortcut {
            sequence: "Ctrl+S"
            onActivated: {
                thickBorder = !thickBorder
                statusText.text = "Ctrl+S - 边框: " + (thickBorder ? "加粗" : "变细")
            }
        }

        // 演示矩形
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            width: 320
            height: 180
            radius: 12
            color: darkBackground ? "#2C3E50" : "#FFFFFF"
            border.color: blueBorder ? "#1296FF" : "#999"
            border.width: thickBorder ? 6 : 2

            Behavior on color { ColorAnimation { duration: 200 } }
            Behavior on border.color { ColorAnimation { duration: 200 } }
            Behavior on border.width { NumberAnimation { duration: 150 } }

            Text {
                anchors.centerIn: parent
                text: "按 Ctrl+T / Ctrl+B / Ctrl+S 试试"
                font.pointSize: 14
                font.bold: true
                color: darkBackground ? "#ECF0F1" : "#666"
            }
        }

        // 当前状态卡片
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            Repeater {
                // 模型只存放静态数据；开/关状态通过根对象的 stateOn()/stateText()
                // 实时求值，保证切换后卡片立即刷新
                model: [
                    { key: "Ctrl+T", label: "背景" },
                    { key: "Ctrl+B", label: "边框色" },
                    { key: "Ctrl+S", label: "边框粗" }
                ]
                delegate: Rectangle {
                    width: 110
                    height: 54
                    radius: 8
                    color: stateOn(index) ? "#1296FF" : "#FFFFFF"
                    border.color: stateOn(index) ? "#1296FF" : "#ddd"
                    border.width: 1

                    Behavior on color { ColorAnimation { duration: 150 } }

                    Column {
                        anchors.centerIn: parent
                        spacing: 2

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.key
                            font.pointSize: 10
                            font.bold: true
                            color: stateOn(index) ? "white" : "#1296FF"
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData.label + ": " + stateText(index)
                            font.pointSize: 9
                            color: stateOn(index) ? "white" : "#999"
                        }
                    }
                }
            }
        }

        Text {
            id: statusText
            Layout.alignment: Qt.AlignHCenter
            text: "按 Ctrl+T / Ctrl+B / Ctrl+S 切换矩形属性"
            font.pointSize: 12
            color: "#999"
        }

        Item { Layout.fillHeight: true }
    }
}
