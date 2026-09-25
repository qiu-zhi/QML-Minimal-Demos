import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

FadeInAnimation {
    TableModel {
        id: tableModel
        TableModelColumn { display: "name" }
        TableModelColumn { display: "age" }
        TableModelColumn { display: "occupation" }

        rows: [
            { name: "张三",  age: "25", occupation: "工程师"   },
            { name: "李四",  age: "30", occupation: "设计师"   },
            { name: "王五",  age: "28", occupation: "产品经理" },
            { name: "赵六",  age: "35", occupation: "销售经理" }
        ]
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // 标题与描述
        TitleSeparator {
            title: "基础表格"
            description: "使用 TableModel + TableView 展示静态数据，列宽与行高通过 provider 函数指定"
        }

        // 表头
        Rectangle {
            Layout.fillWidth: true
            height: 40
            color: "#1296FF"
            radius: 4

            Row {
                anchors.fill: parent
                Repeater {
                    model: ["姓名", "年龄", "职业"]
                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        color: "transparent"
                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: "white"
                            font.bold: true
                            font.pixelSize: 14
                        }
                    }
                }
            }
        }

        // 表格
        TableView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: tableModel
            columnSpacing: 1
            rowSpacing: 1

            delegate: Rectangle {
                implicitWidth: 120
                implicitHeight: 40
                border.width: 1
                border.color: "#dddddd"
                color: "#ffffff"

                Text {
                    anchors.centerIn: parent
                    text: display
                    color: "#333"
                    font.pixelSize: 13
                }
            }

            // 三等分：减去两条列间距，最后一列的右边框才不会被裁掉
            columnWidthProvider: function(column) {
                if (column < 3) return (width - 2) / 3
                return 0
            }
            rowHeightProvider: function(row) { return 40 }
        }

        // 提示信息
        Text {
            Layout.fillWidth: true
            text: "共 4 行数据 · 列宽按控件宽度三等分 · 行高固定 40px"
            color: "#999"
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
