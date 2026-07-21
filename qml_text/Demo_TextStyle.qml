import QtQuick
import QtQuick.Layouts

DemoPage {
    title: "Text 文本样式"
    description: "演示文本样式效果：Normal（默认）、Outline（轮廓）、Raised（凸起）、Sunken（凹陷）"

    Row {
        spacing: 15

        Text {
            font.pointSize: 14
            text: "Normal"
            style: Text.Normal
        }

        Text {
            font.pointSize: 14
            text: "Outline"
            style: Text.Outline
            styleColor: "red"
        }

        Text {
            font.pointSize: 14
            text: "Raised"
            style: Text.Raised
            styleColor: "#AAAAAA"
        }

        Text {
            font.pointSize: 14
            text: "Sunken"
            style: Text.Sunken
            styleColor: "#AAAAAA"
        }
    }

    Rectangle {
        Layout.fillWidth: true
        height: 1
        color: "#eee"
    }

    Repeater {
        model: ["Normal: 默认样式", "Outline: 轮廓效果", "Raised: 凸起效果", "Sunken: 凹陷效果"]
        Text {
            text: "- " + modelData
            font.pointSize: 10
            color: "#666"
        }
    }
}
