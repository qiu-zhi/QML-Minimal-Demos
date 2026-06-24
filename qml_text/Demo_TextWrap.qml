import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 文本换行"
            description: "演示 wrapMode 属性：NoWrap（不换行）、WordWrap（单词边界换行）、Wrap（任意位置换行）"
        }

        ColumnLayout {
            Layout.leftMargin: 20
            spacing: 15

            Text {
                Layout.preferredWidth: 250
                text: "NoWrap: This is a very long text that will not wrap by default"
                wrapMode: Text.NoWrap
                font.pointSize: 12
                Rectangle { anchors.fill: parent; color: "#fff3e0"; border.color: "#ffb74d"; z: -1}
            }

            Text {
                Layout.preferredWidth: 250
                text: "WordWrap: This is a very long text that only wraps at word boundaries"
                wrapMode: Text.WordWrap
                font.pointSize: 12
                Rectangle { anchors.fill: parent; color: "#e8f5e9"; border.color: "#66bb6a"; z: -1 }
            }

            Text {
                Layout.preferredWidth: 250
                text: "Wrap: This is a very long text that prefers word boundaries but can break anywhere if needed"
                wrapMode: Text.Wrap
                font.pointSize: 12
                Rectangle { anchors.fill: parent; color: "#e3f2fd"; border.color: "#42a5f5"; z: -1 }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
