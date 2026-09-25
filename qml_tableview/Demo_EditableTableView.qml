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
    readonly property color editingColor: "#FFE082"
    readonly property color borderColor: "#e0e0e0"

    // 编辑状态
    property bool isEditing: false
    property int editingRow: -1
    property int editingColumn: -1

    TableModel {
        id: tableModel
        TableModelColumn { display: "product" }
        TableModelColumn { display: "price"   }
        TableModelColumn { display: "stock"   }

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
            title: "可编辑表格"
            description: "点击价格或库存单元格进入编辑状态，回车确认修改，仅允许输入数字"
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
                    model: ["产品", "价格 (可编辑)", "库存 (可编辑)"]
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
            model: tableModel
            columnSpacing: 1
            rowSpacing: 1

            delegate: Rectangle {
                implicitWidth: 120
                implicitHeight: rowHeight
                color: (row === editingRow && column === editingColumn) ? editingColor :
                       row === selectedRow ? selectedColor :
                       row === hoveredRow  ? hoverColor :
                       row % 2             ? "#f5f5f5" : "white"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        selectedRow = row
                        if (column > 0) {
                            editingRow = row
                            editingColumn = column
                            textInput.text = display
                            textInput.visible = true
                            textInput.focus = true
                        }
                    }
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
                    color: column === 1 ? "#E91E63" : "#333333"
                    font.pixelSize: column === 1 ? 14 : 13
                    font.bold: column === 1
                    visible: !(row === editingRow && column === editingColumn)
                }

                TextField {
                    id: textInput
                    anchors.fill: parent
                    anchors.margins: 2
                    visible: row === editingRow && column === editingColumn
                    text: display
                    selectByMouse: true
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: TextInput.AlignVCenter

                    onAccepted: {
                        if (/^\d+$/.test(text)) {
                            let newCell = tableModel.getRow(row)
                            newCell[column === 1 ? "price" : "stock"] = text
                            tableModel.setRow(row, newCell)
                        }
                        visible = false
                        editingRow = -1
                        editingColumn = -1
                    }

                    onFocusChanged: {
                        if (!focus) {
                            visible = false
                            editingRow = -1
                            editingColumn = -1
                        }
                    }

                    validator: IntValidator { bottom: 0; top: 999999 }
                }
            }

            // 三等分：减去两条列间距，最后一列的右边框才不会被裁掉
            columnWidthProvider: function(col) { return (width - 2) / 3 }
            rowHeightProvider: function(row) { return rowHeight }
        }

        // 提示信息
        Text {
            Layout.fillWidth: true
            text: "点击价格或库存单元格进行编辑 · 仅允许整数 · 回车确认"
            color: "#666"
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
