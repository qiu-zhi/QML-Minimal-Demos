import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    id: root

    FontLoader { id: kuaileLoader; source: "qrc:/fonts/ZCOOLKuaiLe-Regular.ttf" }
    FontLoader { id: hanLoader; source: "qrc:/fonts/SourceHanSansSC-Regular-2.otf" }

    // 一次字体查询：只要 family，其余用默认值
    FontInfo {
        id: info
        font.family: familyBox.currentText
    }

    component ResultItem: ColumnLayout {
        property string label
        property string value

        spacing: 2

        Text {
            text: label
            font.pointSize: 9
            color: "#9AA0A6"
        }

        Text {
            text: value
            font.pointSize: 12
            font.bold: true
            color: "#1296FF"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "字体信息"
            description: "FontInfo 报告 Qt 实际匹配到的字体。请求一个不存在的字族时，看 family 就知道被换成了什么。"
        }

        // 上：查询条件
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Text {
                text: "请求的字族"
                font.pointSize: 10
                color: "#7A8288"
            }

            ComboBox {
                id: familyBox
                Layout.preferredWidth: 220
                model: [kuaileLoader.name, hanLoader.name, "NoSuchFont"]
            }

            Item { Layout.fillWidth: true }
        }

        // 中：用请求的字族渲染预览
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FFFFFF"
            border.color: "#E6E6E6"
            radius: 8
            clip: true

            Text {
                anchors.centerIn: parent
                text: "字体预览 FontInfo 123"
                font.family: familyBox.currentText
                font.pointSize: 24
                color: "#333333"
            }

            Text {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.margins: 14
                text: "这块文字用的是请求的字族"
                font.pointSize: 9
                color: "#9AA0A6"
            }
        }

        // 下：实际匹配到的结果
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 68
            color: "#F7F8FA"
            border.color: "#E6E6E6"
            radius: 8

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 24

                ResultItem { label: "实际 family"; value: info.family }
                ResultItem { label: "styleName"; value: info.styleName }
                ResultItem { label: "weight"; value: info.weight.toFixed(0) }
                ResultItem { label: "fixedPitch"; value: info.fixedPitch ? "true" : "false" }

                Item { Layout.fillWidth: true }
            }
        }
    }
}
