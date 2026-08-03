import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "水平滚动"
            description: "使用 PathView 实现水平方向的滚轮选择器效果"
        }

        PathView {
            id: pathView
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            Layout.alignment: Qt.AlignHCenter
            model: ["北京", "上海", "广州", "深圳", "杭州", "成都", "武汉", "南京", "西安", "重庆"]
            currentIndex: 2
            pathItemCount: 7
            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5
            highlightRangeMode: PathView.StrictlyEnforceRange
            dragMargin: pathView.width / 2

            path: Path {
                startX: 0
                startY: pathView.height / 2
                PathAttribute { name: "itemScale"; value: 0.6 }
                PathAttribute { name: "itemOpacity"; value: 0.3 }
                PathLine { x: pathView.width / 2; y: pathView.height / 2 }
                PathAttribute { name: "itemScale"; value: 1.0 }
                PathAttribute { name: "itemOpacity"; value: 1.0 }
                PathLine { x: pathView.width; y: pathView.height / 2 }
                PathAttribute { name: "itemScale"; value: 0.6 }
                PathAttribute { name: "itemOpacity"; value: 0.3 }
            }

            delegate: Text {
                width: 80
                height: pathView.height
                text: modelData
                font.pixelSize: 14 + PathView.itemScale * 6
                color: PathView.isCurrentItem ? "#e91e63" : "#333"
                font.bold: PathView.isCurrentItem
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: PathView.itemOpacity
                scale: PathView.itemScale
            }

            // 中间高亮背景
            Rectangle {
                width: 80
                height: parent.height * 0.55
                radius: 8
                color: "#e91e63"
                opacity: 0.12
                x: parent.width / 2 - width / 2
                y: parent.height / 2 - height / 2
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "当前选择: " + pathView.model[pathView.currentIndex]
            font.pointSize: 13
            color: "#e91e63"
            font.bold: true
        }

        Item { Layout.fillHeight: true }
    }
}
