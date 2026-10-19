import QtQuick

Item {
    // 页面加载后淡入，替代 states + transitions 的写法
    opacity: 0

    default property alias content: contentContainer.data

    NumberAnimation on opacity {
        from: 0
        to: 1
        duration: 666
        easing.type: Easing.OutQuad
    }

    Item {
        id: contentContainer
        anchors.fill: parent
    }
}