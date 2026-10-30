import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    // 弹性布局里的一个方块：尺寸用 implicitWidth/implicitHeight 交给布局计算
    component FlexItem: Rectangle {
        property string label
        property int boxHeight: 44
        property color boxColor

        implicitWidth: 140
        implicitHeight: boxHeight
        radius: 6
        color: boxColor

        Text {
            anchors.centerIn: parent
            text: parent.label
            color: "white"
            font.pointSize: 11
            font.bold: true
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "弹性布局"
            description: "FlexboxLayout 是 Qt 6.10 起的技术预览布局；主轴即排列方向所在的轴，交叉轴与它垂直。四个下拉框控制方向、换行、主轴对齐、交叉轴对齐，滑块控制间距。"
        }

        // 四个属性排成两行，每行两组“中文标题 + 下拉框”
        GridLayout {
            Layout.fillWidth: true
            columns: 4
            columnSpacing: 12
            rowSpacing: 8

            Label { text: "排列方向"; color: "#666"; font.pointSize: 10; Layout.preferredWidth: 76 }
            ComboBox {
                id: dirBox
                Layout.fillWidth: true
                Layout.preferredWidth: 140
                Layout.minimumWidth: 120
                textRole: "text"
                valueRole: "value"
                model: [
                    { text: "从左到右", value: FlexboxLayout.Row },
                    { text: "从右到左", value: FlexboxLayout.RowReverse },
                    { text: "从上到下", value: FlexboxLayout.Column },
                    { text: "从下到上", value: FlexboxLayout.ColumnReverse }
                ]
            }

            Label { text: "换行"; color: "#666"; font.pointSize: 10; Layout.preferredWidth: 76 }
            ComboBox {
                id: wrapBox
                Layout.fillWidth: true
                Layout.preferredWidth: 140
                Layout.minimumWidth: 120
                currentIndex: 1
                textRole: "text"
                valueRole: "value"
                model: [
                    { text: "不换行（默认）", value: FlexboxLayout.NoWrap },
                    { text: "换行", value: FlexboxLayout.Wrap },
                    { text: "反向换行", value: FlexboxLayout.WrapReverse }
                ]
            }

            Label { text: "主轴对齐"; color: "#666"; font.pointSize: 10; Layout.preferredWidth: 76 }
            ComboBox {
                id: justifyBox
                Layout.fillWidth: true
                Layout.preferredWidth: 140
                Layout.minimumWidth: 120
                textRole: "text"
                valueRole: "value"
                model: [
                    { text: "起始（默认）", value: FlexboxLayout.JustifyStart },
                    { text: "居中", value: FlexboxLayout.JustifyCenter },
                    { text: "末尾", value: FlexboxLayout.JustifyEnd },
                    { text: "两端分散", value: FlexboxLayout.JustifySpaceBetween },
                    { text: "环绕分散", value: FlexboxLayout.JustifySpaceAround },
                    { text: "均匀分散", value: FlexboxLayout.JustifySpaceEvenly }
                ]
            }

            Label { text: "交叉轴对齐"; color: "#666"; font.pointSize: 10; Layout.preferredWidth: 76 }
            ComboBox {
                id: alignBox
                Layout.fillWidth: true
                Layout.preferredWidth: 140
                Layout.minimumWidth: 120
                textRole: "text"
                valueRole: "value"
                model: [
                    { text: "起始（默认）", value: FlexboxLayout.AlignStart },
                    { text: "居中", value: FlexboxLayout.AlignCenter },
                    { text: "末尾", value: FlexboxLayout.AlignEnd }
                ]
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Label { text: "间距"; color: "#666"; font.pointSize: 10; Layout.preferredWidth: 76 }

            Slider {
                id: gapSlider
                Layout.fillWidth: true
                from: 0
                to: 60
                value: 8
                stepSize: 2
            }

            Text {
                text: gapSlider.value.toFixed(0) + " px"
                font.pointSize: 10
                font.bold: true
                color: "#1296FF"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#FFFFFF"
            border.color: "#e0e0e0"
            radius: 8
            clip: true

            FlexboxLayout {
                anchors.fill: parent
                anchors.margins: 12
                direction: dirBox.currentValue
                wrap: wrapBox.currentValue
                justifyContent: justifyBox.currentValue
                alignItems: alignBox.currentValue
                gap: gapSlider.value

                FlexItem { label: "1"; boxColor: "#1296FF" }
                FlexItem { label: "2"; boxHeight: 60; boxColor: "#E67E22" }
                FlexItem { label: "3"; boxHeight: 24; boxColor: "#2E9E5B" }
                FlexItem { label: "4"; boxColor: "#9B59B6" }
                FlexItem { label: "5"; boxHeight: 60; boxColor: "#16A085" }
                FlexItem { label: "6"; boxHeight: 24; boxColor: "#E74C3C" }
            }
        }
    }
}
