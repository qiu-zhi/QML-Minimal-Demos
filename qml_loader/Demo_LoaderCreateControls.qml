import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FadeInAnimation {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "动态创建控件"
            description: "使用 Qt.createComponent 和 createObject 在容器中动态创建控件实例"
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Button {
                text: "创建矩形"
                onClicked: {
                    var component = Qt.createComponent("component/ColorRect.qml");
                    if (component.status === Component.Ready) {
                        var object = component.createObject(container, {
                            "x": Math.random() * Math.max(0, container.width - 50),
                            "y": Math.random() * Math.max(0, container.height - 50)
                        });
                        if (object === null) {
                            console.log("Error creating object");
                        }
                    } else if (component.status === Component.Error) {
                        console.log("Error loading component:", component.errorString());
                    }
                }
            }

            Button {
                text: "清空"
                onClicked: {
                    var children = container.children.slice();
                    for (var i = 0; i < children.length; i++) {
                        children[i].destroy();
                    }
                }
            }
        }

        Rectangle {
            id: container
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Qt.rgba(0.95, 0.95, 0.95, 1)
            radius: 4
            clip: true
        }

        Text {
            text: "子控件数量: " + container.children.length
            font.pointSize: 11
            color: "#666"
        }
    }
}
