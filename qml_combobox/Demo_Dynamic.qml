import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "动态更新模型"
            description: "运行时通过数组操作动态添加选项，Component.onCompleted 中使用 Qt.callLater 模拟异步加载"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            ComboBox {
                id: dynamicCombo
                Layout.fillWidth: true
                Layout.preferredHeight: 30

                Component.onCompleted: {
                    // 模拟异步加载数据
                    Qt.callLater(function() {
                        dynamicCombo.model = ["动态加载1", "动态加载2", "动态加载3"]
                    })
                }
            }

            Button {
                Layout.preferredHeight: 30
                text: "添加选项"
                onClicked: {
                    if (dynamicCombo.model instanceof Array) {
                        var newModel = dynamicCombo.model.slice()
                        newModel.push("新选项" + (newModel.length + 1))
                        dynamicCombo.model = newModel
                    }
                }
            }
        }

        Text {
            id: textResult
            Layout.fillWidth: true
            color: "#333"
            font.pointSize: 11
            text: dynamicCombo.currentIndex >= 0
                  ? "当前选择: " + dynamicCombo.currentText
                  : "未选择"
        }

        Item { Layout.fillHeight: true }
    }
}
