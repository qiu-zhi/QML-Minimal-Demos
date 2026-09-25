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

    // 排序相关属性
    property int sortColumn: -1
    property bool ascending: true

    // 列定义
    property var columns: [
        { title: "产品", role: "product" },
        { title: "价格", role: "price"   },
        { title: "库存", role: "stock"   }
    ]

    // 数据模型
    TableModel {
        id: originalModel
        TableModelColumn { display: "product" }
        TableModelColumn { display: "price"   }
        TableModelColumn { display: "stock"   }

        rows: [
            { product: "笔记本电脑", price: 6999, stock: 15 },
            { product: "手机",       price: 3999, stock: 25 },
            { product: "平板电脑",   price: 4599, stock: 10 },
            { product: "智能手表",   price: 1999, stock: 30 }
        ]
    }

    // 排序后的数据模型
    TableModel {
        id: sortedModel
        TableModelColumn { display: "product" }
        TableModelColumn { display: "price"   }
        TableModelColumn { display: "stock"   }
    }

    // 排序函数
    function sortModel() {
        let items = []
        for (let i = 0; i < originalModel.rowCount; i++) {
            items.push({
                product: originalModel.getRow(i).product,
                price:   originalModel.getRow(i).price,
                stock:   originalModel.getRow(i).stock
            })
        }
        if (sortColumn !== -1) {
            let role = columns[sortColumn].role
            items.sort((a, b) => {
                let aValue = a[role]
                let bValue = b[role]
                if (typeof aValue === "string") {
                    return ascending ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue)
                } else {
                    return ascending ? aValue - bValue : bValue - aValue
                }
            })
        }
        sortedModel.rows = items
    }

    Component.onCompleted: { sortModel() }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // 标题与描述
        TitleSeparator {
            title: "可排序表格"
            description: "点击表头按列升降序排序，再次点击切换方向，表头显示 ▲▼ 箭头"
        }

        // 表头（可点击排序）
        Rectangle {
            Layout.fillWidth: true
            height: rowHeight
            color: headerColor
            radius: 4

            Row {
                anchors.fill: parent
                Repeater {
                    model: columns
                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        color: "transparent"

                        Row {
                            anchors.centerIn: parent
                            spacing: 5

                            Text {
                                text: modelData.title
                                color: "white"
                                font.bold: true
                                font.pixelSize: 14
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                visible: sortColumn === index
                                text: ascending ? "▲" : "▼"
                                color: "white"
                                font.bold: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (sortColumn === index) {
                                    ascending = !ascending
                                } else {
                                    sortColumn = index
                                    ascending = true
                                }
                                sortModel()
                            }
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
            model: sortedModel
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
            text: sortColumn === -1
                  ? "点击表头排序"
                  : "当前按【" + columns[sortColumn].title + "】" + (ascending ? "升序" : "降序")
            color: "#666"
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
