import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Flow 流式布局"
            description: "自动换行排列，适合标签、按钮组等不规则尺寸内容"
        }

        // Flow 布局示例
        Flow {
            spacing: 10
            Layout.fillWidth: true
            Layout.fillHeight: true

            Repeater {
                model: 10
                Rectangle {
                    width: Math.random() * 120 + 80
                    height: 40
                    color: ["#e3f2fd", "#e8f5e9", "#ffebee"][index % 3]
                    border.color: ["#90CAF9", "#A5D6A7", "#EF9A9A"][index % 3]
                    radius: 20

                    Text {
                        anchors.centerIn: parent
                        text: "Tag " + (index + 1)
                        font.pointSize: 10
                        color: "#333"
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#eee"
        }

        // 说明
        Note {
            text: "**说明：**\n- Flow: 流式布局，根据父容器宽度自动换行\n- 适合标签云、按钮组、不规则尺寸内容排列"
        }
    }
}
