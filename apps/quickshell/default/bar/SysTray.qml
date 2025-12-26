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

        Repeater {
            model: SystemTray.items

            delegate: MouseArea {
                id: trayItemRoot
                required property SystemTrayItem modelData

                Layout.preferredWidth: trayItem.implicitWidth
                Layout.preferredHeight: trayItem.implicitHeight
                Layout.alignment: Qt.AlignVCenter
                hoverEnabled: true

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
            }
        }
    }
}
