import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 属性定义
    property int selectedRow: -1
    property int hoveredRow: -1
    readonly property int rowHeight: 40

    // 颜色定义
    readonly property color headerColor: "#1296FF"
    readonly property color selectedColor: "#BCE6FF"
    readonly property color hoverColor: "#E5F3FF"
    readonly property color borderColor: "#e0e0e0"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // 标题与描述
        TitleSeparator {
            title: "SQLite 表格（增删改查）"
            description: "C++ 端 QSqlTableModel 提供数据源 · 演示新增、删除、修改并提交到 SQLite 数据库"
        }

        // 操作栏
        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Button {
                text: "新增"
                highlighted: true
                onClicked: recordDialog.openForAdd()
            }
            Button {
                text: "删除"
                enabled: selectedRow >= 0
                onClicked: {
                    sqlModel.removeRow(selectedRow)
                    sqlModel.saveAll()
                    sqlModel.select()
                    selectedRow = -1
                }
            }
            Button {
                text: "修改"
                enabled: selectedRow >= 0
                onClicked: recordDialog.openForEdit(sqlModel.cell(selectedRow, 1),
                                                    sqlModel.cell(selectedRow, 2))
            }
            Item { Layout.fillWidth: true }
            Label {
                // sqlModel.count 是 C++ 侧的 Q_PROPERTY（rowCount 是方法，拼字符串会得到函数体）
                text: "共 " + sqlModel.count + " 条记录"
                color: "#666"
                font.pixelSize: 11
            }
        }

        // 表头：与其他示例同一套蓝色圆角表头。
        // HorizontalHeaderView 负责列宽同步与拖拽调宽，委托只画文字（不画底色），
        // 底色由外层 Rectangle 提供，这样 1px 列间距不会露出白缝。
        Rectangle {
            Layout.fillWidth: true
            height: rowHeight
            color: headerColor
            radius: 4

            HorizontalHeaderView {
                id: tableHeader
                anchors.fill: parent
                syncView: table
                columnSpacing: 1
                resizableColumns: true

                delegate: Item {
                    required property int column

                    // 表头需要从委托的 implicitHeight 推出自身高度，给 0 会报
                    // "the delegate's implicitHeight needs to be greater than zero"
                    implicitWidth: 120
                    implicitHeight: rowHeight

                    Text {
                        anchors.centerIn: parent
                        // 第 0 列是主键 id（宽度 0，已隐藏），所以 1 / 2 列对应 姓名 / 年龄
                        text: column === 1 ? "姓名" : "年龄"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 14
                    }
                }
            }
        }

        // 表格内容
        TableView {
            id: table
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true

            selectionMode: TableView.SingleSelection
            model: sqlModel
            columnSpacing: 1
            rowSpacing: 1

            // 第 0 列是主键 id，宽度置 0 隐藏；其余两列平分剩余宽度
            columnWidthProvider: function(col) {
                return col === 0 ? 0 : (width - 1) / 2
            }

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
                    text: model.display
                    color: "#333"
                    font.pixelSize: 13
                }
            }
        }

        // 操作提示
        Text {
            Layout.fillWidth: true
            text: selectedRow >= 0
                  ? "已选中第 " + (selectedRow + 1) + " 行"
                  : "点击行选中后可执行删除或修改"
            color: "#666"
            font.pixelSize: 11
            horizontalAlignment: Text.AlignHCenter
        }
    }

    // 新增 / 修改弹窗：界面与样式在 RecordDialog.qml，这里只接信号做数据库操作
    RecordDialog {
        id: recordDialog

        onRecordAdded: function(name, age) {
            sqlModel.appendRow(name, age)
            // 立即提交并刷新，确保数据持久化且视图更新
            sqlModel.saveAll()
            sqlModel.select()
        }

        onRecordEdited: function(name, age) {
            sqlModel.editRow(selectedRow, name, age)
            sqlModel.saveAll()
            sqlModel.select()
        }
    }
}
