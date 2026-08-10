import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 字体与颜色：自定义 TextArea 的字体族、字号、字色与选区颜色
FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        TitleSeparator {
            title: "字体与颜色"
            description: "通过 font 属性族、color、selectionColor 等自定义文本外观"
        }

        TextArea {
            id: styledTextArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "自定义字体和颜色的文本区域"

            font {
                family: "Courier New"
                pixelSize: 14
                bold: true
                italic: false
            }

            color: "blue"
            selectionColor: "#1296FF"
            selectedTextColor: "white"
            placeholderTextColor: "#aaa"
        }
    }
}
