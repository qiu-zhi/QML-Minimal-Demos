import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

FadeInAnimation {
    // 属性定义
    property int selectedRow: -1
    property int hoveredRow: -1
    readonly property int rowHeight: 40

    // 颜色定义
    readonly property color headerColor: "#1296FF"
    readonly property color selectedColor: "#BCE6FF"
    readonly property color hoverColor: "#E5F3FF"
    readonly property color priceColor: "#E91E63"
    readonly property color borderColor: "#e0e0e0"

    TableModel {
        id: customTableModel
        TableModelColumn { display: "product" }
        TableModelColumn { display: "price" }
        TableModelColumn { display: "stock" }

        rows: [
            { product: "笔记本电脑", price: "6999", stock: "15" },
            { product: "手机",       price: "3999", stock: "25" },
            { product: "平板电脑",   price: "4599", stock: "10" },
            { product: "智能手表",   price: "1999", stock: "30" }
        ]
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // 标题与描述
        TitleSeparator {
            title: "自定义样式表格"
            description: "自定义表头、行悬停高亮、选中行变色、价格列特殊样式、斑马纹背景"
        }

        // 表头
        Rectangle {
            Layout.fillWidth: true
            height: rowHeight
            color: headerColor
            radius: 4

            Row {
                anchors.fill: parent
                Repeater {
                    model: ["产品", "价格", "库存"]
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

        // 表格内容
        TableView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: customTableModel
            columnSpacing: 1
            rowSpacing: 1

            delegate: Rectangle {
                implicitWidth: 120
                implicitHeight: rowHeight
                color: row === selectedRow ? selectedColor :
                       row === hoveredRow  ? hoverColor :
                       row % 2             ? "#f5f5f5" : "white"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: selectedRow = row
                    onEntered: hoveredRow = row
                    onExited:  hoveredRow = -1
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: borderColor
                    anchors.bottom: parent.bottom
                }

                Text {
                    anchors.centerIn: parent
                    text: column === 1 ? "¥" + display : display
                    color: column === 1 ? priceColor : "#333333"
                    font.pixelSize: column === 1 ? 14 : 13
                    font.bold: column === 1
                }
            }

            // 三等分：减去两条列间距，最后一列的右边框才不会被裁掉
            columnWidthProvider: function(col) { return (width - 2) / 3 }
            rowHeightProvider: function(row) { return rowHeight }
        }

        // 提示信息
        Text {
            Layout.fillWidth: true
            text: selectedRow >= 0
                  ? "已选中第 " + (selectedRow + 1) + " 行"
                  : "悬停查看高亮 · 点击行可选中"
            color: "#666"
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
