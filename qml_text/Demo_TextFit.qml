import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 字体自适应"
            description: "演示 fontSizeMode 属性：文本自动缩放以填充容器"
        }

        // HorizontalFit - 适配宽度（高度固定，宽度变化时字体跟着变）
        Rectangle {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 40
            color: "#fff3e0"
            border.color: "#ffb74d"
            radius: 4

            Text {
                anchors.fill: parent
                anchors.margins: 4
                text: "HorizontalFit 适配宽度"
                fontSizeMode: Text.HorizontalFit
                font.pixelSize: 72
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // VerticalFit - 适配高度（宽度固定，高度变化时字体跟着变）
        Rectangle {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 50
            color: "#e3f2fd"
            border.color: "#42a5f5"
            radius: 4

            Text {
                anchors.fill: parent
                anchors.margins: 4
                text: "VerticalFit 适配高度"
                fontSizeMode: Text.VerticalFit
                font.pixelSize: 72
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // Fit - 适配宽高
        Rectangle {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 60
            color: "#e8f5e9"
            border.color: "#66bb6a"
            radius: 4

            Text {
                anchors.fill: parent
                anchors.margins: 4
                text: "Fit 适配宽高"
                fontSizeMode: Text.Fit
                minimumPixelSize: 10
                font.pixelSize: 72
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // 拖拽容器 - 实时观察 Fit 效果
        Rectangle {
            id: resizableBox
            Layout.preferredWidth: 300
            Layout.preferredHeight: 60
            color: "#f3e5f5"
            border.color: "#ab47bc"
            border.width: 2
            radius: 4

            Text {
                anchors.fill: parent
                anchors.margins: 4
                text: "拖动改变大小"
                fontSizeMode: Text.Fit
                minimumPixelSize: 10
                font.pixelSize: 72
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // 右下角拖拽手柄（使用绝对差值计算，避免浮点漂移）
            MouseArea {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: 24
                height: 24
                cursorShape: Qt.SizeFDiagCursor
                preventStealing: true

                property real pressX
                property real pressY
                property real baseW
                property real baseH

                onPressed: (mouse) => {
                    pressX = mouse.x
                    pressY = mouse.y
                    baseW = resizableBox.width
                    baseH = resizableBox.height
                }
                onPositionChanged: (mouse) => {
                    var newW = baseW + (mouse.x - pressX)
                    var newH = baseH + (mouse.y - pressY)
                    if (newW > 80) resizableBox.width = newW
                    if (newH > 30) resizableBox.height = newH
                }
            }

            Text {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 2
                text: "↘"
                font.pointSize: 8
                color: "#ab47bc"
            }
        }

        Item { Layout.fillHeight: true }

        Note {
            text: "- 以上所有 Text 的 font.pixelSize 均为 72px，实际显示大小由容器尺寸和 fontSizeMode 自动决定"
        }
    }
}
