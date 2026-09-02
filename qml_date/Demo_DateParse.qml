import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "日期解析"
            description: "使用 Date.fromLocaleString() 将字符串解析为日期对象，解析格式必须与输入字符串完全匹配"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 8
            border.color: "#e0e0e0"

            GridLayout {
                anchors.fill: parent
                anchors.margins: 20
                columns: 2
                columnSpacing: 20
                rowSpacing: 15

                // ===== 静态示例 =====
                Text {
                    text: "固定格式示例:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    property var parsed: Date.fromLocaleString(Qt.locale(), "2025-04-25 14:30:00", "yyyy-MM-dd hh:mm:ss")
                    text: "解析 \"2025-04-25 14:30:00\" → " + parsed.toLocaleString(Qt.locale())
                    font.pixelSize: 13
                    color: "#333"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                // ===== 交互区：格式选择 =====
                Text {
                    text: "解析格式:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                ComboBox {
                    id: fmtCombo
                    Layout.fillWidth: true
                    Layout.preferredWidth: 280
                    font.pixelSize: 13
                    model: ListModel {
                        ListElement { fmt: "yyyy-MM-dd"; hint: "2025-12-25" }
                        ListElement { fmt: "yyyy-MM-dd hh:mm:ss"; hint: "2025-04-25 14:30:00" }
                        ListElement { fmt: "yyyy/MM/dd"; hint: "2025/04/25" }
                        ListElement { fmt: "yyyy年MM月dd日"; hint: "2025年04月25日" }
                        ListElement { fmt: "yyyy-MM-dd hh:mm AP"; hint: "2025-04-25 02:30 PM" }
                    }
                    textRole: "fmt"

                    // 切换格式时，自动把输入框内容换成该格式的示例
                    onCurrentIndexChanged: {
                        var item = model.get(currentIndex)
                        inputField.placeholderText = item.hint
                        inputField.text = item.hint
                    }
                    Component.onCompleted: currentIndex = 1
                }

                // ===== 交互区：输入 =====
                Text {
                    text: "输入字符串:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                TextField {
                    id: inputField
                    Layout.fillWidth: true
                    Layout.preferredWidth: 280
                    font.pixelSize: 13
                    placeholderText: "yyyy-MM-dd"
                    selectByMouse: true
                }

                // ===== 交互区：结果 =====
                Text {
                    text: "解析结果:"
                    font.pixelSize: 13
                    font.bold: true
                    color: "#333"
                    Layout.alignment: Qt.AlignTop
                }
                Text {
                    id: resultText
                    property string fmt: fmtCombo.currentText
                    property var parsed: Date.fromLocaleString(Qt.locale(), inputField.text, fmt)
                    property bool hasTime: fmt.indexOf("hh") >= 0 || fmt.indexOf("HH") >= 0
                    text: isNaN(parsed.getTime())
                          ? "✗ 无效日期（输入与格式不匹配）"
                          : (hasTime
                             ? parsed.toLocaleString(Qt.locale())
                             : parsed.toLocaleDateString(Qt.locale(), Locale.LongFormat))
                    font.pixelSize: 13
                    color: isNaN(parsed.getTime()) ? "#e74c3c" : "#1976D2"
                    wrapMode: Text.Wrap
                    Layout.fillWidth: true
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
