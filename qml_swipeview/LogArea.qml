import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

ScrollView {
    id: scrollView

    // 将textArea暴露给外部
    property alias message: textArea

    ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOn
        anchors.top: scrollView.top
        anchors.bottom: scrollView.bottom
        anchors.right: scrollView.right

        // 保持滚动到底端
        position: {
            if (scrollView.height > 0 && scrollView.contentHeight > scrollView.height) {
                return (scrollView.contentHeight - scrollView.height) / scrollView.contentHeight;
            }
            return 0;
        }
    }

    TextArea {
        id: textArea
        readOnly: true
    }
}
