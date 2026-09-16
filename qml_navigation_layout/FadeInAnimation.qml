import QtQuick

Item {
    id: root
    opacity: 0

    // 页面容器必须裁剪：抽屉、StackView 转场等元素在动画过程中会越出内容区，
    // 若不裁剪就会绘制到左侧导航栏上方。
    clip: true

    default property alias content: contentContainer.data

    Item {
        id: contentContainer
        anchors.fill: parent
    }

    states: State {
        name: "visible"
        when: root.visible

        PropertyChanges { root {
            opacity: 1
        } }
    }

    transitions: Transition {
        from: ""
        to: "visible"

        NumberAnimation {
            property: "opacity"
            duration: 666
            easing.type: Easing.OutQuad
        }
    }
}
