pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import "../constants.js" as Constants

Item {
    id: root

    required property QsMenuHandle menu
    signal requestClose

    QsMenuOpener {
        id: menus
        menu: root.menu
    }

    ColumnLayout {
        id: menuColumn
        anchors.margins: 8
        spacing: 4
        anchors.centerIn: parent

        Repeater {
            model: menus.children

            delegate: Loader {
                id: entryLoader
                required property QsMenuEntry modelData

                Layout.fillWidth: true
                sourceComponent: modelData.isSeparator ? separator : entry

                Component {
                    id: separator
                    Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: 1
                        color: Constants.surface1
                        opacity: 0.5
                        Layout.topMargin: 4
                        Layout.bottomMargin: 4
                    }
                }

                Component {
                    id: entry
                    MouseArea {
                        id: mouseArea
                        implicitWidth: entryLayout.implicitWidth + 20
                        implicitHeight: 32
                        hoverEnabled: true
                        enabled: entryLoader.modelData.enabled

                        Rectangle {
                            anchors.fill: parent
                            color: mouseArea.containsMouse ? Constants.surface0 : "transparent"
                            radius: 5
                        }

                        RowLayout {
                            id: entryLayout
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            anchors.rightMargin: 8
                            spacing: 10

                            IconImage {
                                source: entryLoader.modelData.icon
                                implicitWidth: 16
                                implicitHeight: 16
                                visible: entryLoader.modelData.icon !== ""
                            }

                            Text {
                                Layout.fillWidth: true
                                text: entryLoader.modelData.text.replace("_", "")
                                color: entryLoader.modelData.enabled ? "white" : "#666666"
                                font.pixelSize: 13
                            }

                            // Submenu Indicator
                            Text {
                                text: "›"
                                visible: entryLoader.modelData.hasChildren
                                color: "grey"
                            }
                        }

                        onClicked: {
                            if (!entryLoader.modelData.hasChildren) {
                                // 1. Tell the app to do the thing
                                entryLoader.modelData.triggered();
                                root.requestClose();
                            } else {
                                // Logic for opening submenus would go here
                            }
                        }
                    }
                }
            }
        }
    }
}
