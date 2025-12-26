import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../constants.js" as Constants

Item {
    id: root

    implicitHeight: 40
    Layout.fillWidth: true
    Layout.preferredWidth: 20

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        layoutDirection: Qt.RightToLeft
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        spacing: 10

        Repeater {
            model: SystemTray.items

            delegate: MouseArea {
                id: trayItemRoot
                required property SystemTrayItem modelData
                required property int index
                property bool isVisible

                Layout.preferredWidth: trayItem.implicitWidth
                Layout.preferredHeight: trayItem.implicitHeight
                Layout.alignment: Qt.AlignVCenter
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        modelData.activate();
                    } else if (mouse.button === Qt.RightButton) {
                        isVisible = !isVisible;
                    }
                }

                Rectangle {
                    id: trayItem
                    implicitHeight: 28
                    implicitWidth: 28
                    radius: 10

                    color: trayItemRoot.containsMouse ? Constants.surface0 : Constants.background

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }

                    IconImage {
                        source: trayItemRoot.modelData.icon
                        anchors.centerIn: parent
                        implicitWidth: 24
                        implicitHeight: 24
                    }
                }

                SysTrayMenu {
                    id: menu
                    menu: trayItemRoot.modelData.menu
                    isVisible: trayItemRoot.isVisible
                    offset: 50 + parent.index * (28 + 10)
                    onRequestClose: {
                        trayItemRoot.isVisible = false;
                    }

                    onIsVisibleChanged: {
                        if (menu.isVisible === false) {
                            trayItemRoot.isVisible = false;
                        }
                    }
                }
            }
        }
    }
}
