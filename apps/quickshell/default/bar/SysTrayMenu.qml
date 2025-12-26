pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import "../constants.js" as Constants

Item {
    id: root
    required property QsMenuHandle menu
    // this cannot be overwritten in this component because otherwise it will take the ownership of the value i suppose
    required property bool isVisible
    required property int offset

    signal requestClose

    QsMenuOpener {
        id: menus
        menu: root.menu
    }

    PanelWindow {
        id: popup
        visible: root.isVisible

        implicitWidth: 1000
        implicitHeight: 2000
        exclusiveZone: 0

        anchors {
            top: true
            right: true
        }

        margins {
            top: 10
            right: root.offset
        }

        // Typical window setup for a popup
        color: "transparent"
        mask: Region {
            item: backgroundRect
        }

        Rectangle {
            id: backgroundRect
            color: Constants.background
            border.color: Constants.surface1
            anchors.right: parent.right
            radius: 10

            implicitWidth: menuColumn.implicitWidth + 16 // Add padding
            implicitHeight: menuColumn.implicitHeight + 16 // Add padding

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

                                Loader {
                                    sourceComponent: entryLoader.modelData.hasChildren ? submenu : dummy
                                }

                                Component {
                                    id: dummy
                                    Rectangle {}
                                }

                                Component {
                                    id: submenu
                                    SysTraySubMenu {
                                        menu: entryLoader.modelData
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
    }
}
