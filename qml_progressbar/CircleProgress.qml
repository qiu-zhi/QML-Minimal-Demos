import QtQuick

Item {
    id: root

    // --- 公共属性 ---
    property real value: 0.5
    property bool indeterminate: false
    property int lineWidth: 10
    property color progressColor: "#3498db"
    property color trackColor: "#e6e6e6"
    property int animationDuration: 1000

    implicitWidth: 160
    implicitHeight: 160

    readonly property real radius: Math.min(width, height) / 2 - lineWidth / 2

    // 正常进度动画
    // 注意：不加下划线前缀，否则信号名 _animatedValueChanged 会与 qmlcachegen
    // 的 signal handler 命名校验冲突（下划线属性信号的大小写规则不统一）
    property real animatedValue: value
    Behavior on animatedValue {
        enabled: !root.indeterminate // 不确定模式下禁用此动画
        NumberAnimation { duration: root.animationDuration; easing.type: Easing.OutCubic }
    }

    // Canvas 一次性绘制轨道和进度弧，重绘触发见下方 Connections
    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var cx = width / 2
            var cy = height / 2
            var r = root.radius

            // 第一层：背景轨道
            ctx.beginPath()
            ctx.arc(cx, cy, r, 0, Math.PI * 2)
            ctx.strokeStyle = root.trackColor
            ctx.lineWidth = root.lineWidth
            ctx.stroke()

            // 第二层：进度圆弧
            // 不确定模式固定画 60 度的弧，靠整体旋转动起来；正常模式按进度画
            var sweep = root.indeterminate ? (Math.PI / 3) : (root.animatedValue * Math.PI * 2)
            ctx.beginPath()
            ctx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + sweep)
            ctx.strokeStyle = root.progressColor
            ctx.lineWidth = root.lineWidth
            ctx.lineCap = "round"
            ctx.stroke()
        }

        // 属性变化时重绘
        Connections {
            target: root
            function onAnimatedValueChanged() { canvas.requestPaint() }
            function onIndeterminateChanged() { canvas.requestPaint() }
            function onProgressColorChanged() { canvas.requestPaint() }
            function onTrackColorChanged() { canvas.requestPaint() }
            function onLineWidthChanged() { canvas.requestPaint() }
        }

        // 不确定模式：旋转整个 Canvas，进度弧转起来（轨道是整圆，转了也看不出来）
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 1500
            running: root.indeterminate
            loops: Animation.Infinite
        }
    }

    // 文本显示
    Text {
        anchors.centerIn: parent
        // 不确定模式下隐藏百分比
        text: root.indeterminate ? "加载中" : Math.round(root.animatedValue * 100) + "%"
        font.pixelSize: root.radius * 0.4
        font.bold: true
        color: root.progressColor
        visible: true
    }
}
