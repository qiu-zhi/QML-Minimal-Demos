import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

FadeInAnimation {
    // 定义一个内联 JS 函数
    function calculateArea(w, h) {
        return w * h
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "内联 JS 函数"
            description: "在 QML 中直接定义 JavaScript 函数，可在属性绑定或信号槽中调用"
        }

        Text {
            // 属性绑定调用
            text: "计算面积(属性绑定): " + calculateArea(this.width, this.height)
            font.pointSize: 12
        }

        Button {
            text: "点击计算(在槽函数中调用)"
            font.pointSize: 12

            // 在槽函数中调用
            onClicked: {
                var result = calculateArea(100, 100)
                textResult.text = "Area: " + result
            }
        }

        Text {
            id: textResult
            font.pointSize: 10
        }

        Item { Layout.fillHeight: true }
    }
}
