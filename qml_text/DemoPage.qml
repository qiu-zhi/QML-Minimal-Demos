import QtQuick
import QtQuick.Layouts

FadeInAnimation {
    id: pageRoot
    property alias title: sep.title
    property alias description: sep.description
    default property alias content: contentArea.data

    ColumnLayout {
        id: contentArea
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            id: sep
        }
    }
}
