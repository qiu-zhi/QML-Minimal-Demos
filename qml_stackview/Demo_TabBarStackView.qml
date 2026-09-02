import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "TabBar与StackView"
            description: "TabBar 与 StackView 联动，动态切换、复用页面"
        }

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            TabButton { text: "首页" }
            TabButton { text: "页面1" }
            TabButton { text: "页面2" }

            // 动态切换页面
            onCurrentIndexChanged: {
                // 切换到已存在的视图
                var targetIndex = findPageIndex(currentIndex)
                if (targetIndex >= 0) {
                    // 如果目标页面已存在，直接跳转
                    stack.pop(stack.get(targetIndex))
                } else {
                    // 如果页面不存在，创建新页面
                    stack.push(getPage(currentIndex))
                }
            }
        }

        StackView {
            id: stack
            initialItem: getPage(tabBar.currentIndex)
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
        }
    }

    // 找指定页面在栈中的索引
    function findPageIndex(pageType) {
        for (var i = 0; i < stack.depth; i++) {
            var item = stack.get(i)
            if (item && item.pageType === pageType) {
                return i
            }
        }
        return -1
    }

    function getPage(index) {
        switch(index) {
        case 0: return home
        case 1: return page1
        case 2: return page2
        }
    }

    Component {
        id: home
        Rectangle {
            property int pageType: 0
            color: "#3498db"
            Text {
                anchors.centerIn: parent
                text: "首页 - 持久"
                color: "#fff"
                font.pointSize: 16
            }
        }
    }

    Component {
        id: page1
        Rectangle {
            property int pageType: 1
            color: "#e74c3c"
            Text {
                anchors.centerIn: parent
                text: "页面1 - 临时"
                color: "#fff"
                font.pointSize: 16
            }
        }
    }

    Component {
        id: page2
        Rectangle {
            property int pageType: 2
            color: "#2ecc71"
            Text {
                anchors.centerIn: parent
                text: "页面2 - 临时"
                color: "#fff"
                font.pointSize: 16
            }
        }
    }
}
