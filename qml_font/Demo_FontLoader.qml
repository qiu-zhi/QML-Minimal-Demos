import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    id: root

    // 两个正常字体 + 一个故意写错的路径
    FontLoader { id: kuaileLoader; source: "qrc:/fonts/ZCOOLKuaiLe-Regular.ttf" }
    FontLoader { id: hanLoader; source: "qrc:/fonts/SourceHanSansSC-Regular-2.otf" }
    FontLoader { id: brokenLoader; source: "qrc:/fonts/NotExist.ttf" }

    function statusText(s) {
        if (s === FontLoader.Null)
            return "Null 未设置"
        if (s === FontLoader.Loading)
            return "Loading 加载中"
        if (s === FontLoader.Ready)
            return "Ready 已加载"
        return "Error 加载失败"
    }

    // 一张字体卡片：上面一行写加载结果，下面一行用加载到的字体预览，两行各占满宽度
    component FontCard: Rectangle {
        id: card
        property var loader

        Layout.fillWidth: true
        implicitHeight: body.implicitHeight + 20
        color: "#FFFFFF"
        border.color: "#E6E6E6"
        radius: 8

        ColumnLayout {
            id: body
            anchors.fill: parent
            anchors.margins: 10
            spacing: 2

            Text {
                Layout.fillWidth: true
                text: (loader.status === FontLoader.Ready ? loader.name : "name 为空")
                      + " ｜ " + root.statusText(loader.status)
                font.pointSize: 10
                color: loader.status === FontLoader.Ready ? "#2E9E5B" : "#C0392B"
            }

            Text {
                Layout.fillWidth: true
                text: "字体预览 Font Preview 12345"
                font.family: loader.name
                font.pointSize: 20
                color: "#1296FF"
                elide: Text.ElideRight
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 12

        TitleSeparator {
            title: "加载字体文件"
            description: "FontLoader 从 URL 读入字体文件，加载完成后用 name 指定字体，status 表示加载结果。加载是异步的，就绪前 name 为空。"
        }

        FontCard { loader: kuaileLoader }
        FontCard { loader: hanLoader }
        FontCard { loader: brokenLoader }

        Item { Layout.fillHeight: true }
    }
}
