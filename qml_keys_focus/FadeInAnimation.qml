import QtQuick

// 页面切换时的淡入动画容器：所有 Demo 页面的根元素
Item {
    id: root
    opacity: 0

    // 页面内容直接写在 FadeInAnimation 内部即可
    default property alias content: contentContainer.data

    Item {
        id: contentContainer
        anchors.fill: parent
    }

    // 页面创建完成后播放一次淡入（onVisibleChanged 不会在初始加载时触发）
    Component.onCompleted: fadeIn.start()

    NumberAnimation {
        id: fadeIn
        target: root
        property: "opacity"
        to: 1
        duration: 400
        easing.type: Easing.OutQuad
    }
}
