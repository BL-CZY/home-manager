pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Wayland
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
        WlrLayershell.namespace: "tray_menu"

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

            implicitWidth: root.isVisible ? menuColumn.implicitWidth + 16 : 0 // Add padding
            implicitHeight: root.isVisible ? menuColumn.implicitHeight + 16 : 0 // Add padding

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 700
                    easing.type: Easing.OutExpo
                }
            }

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 700
                    easing.type: Easing.OutExpo
                }
            }

            clip: true

            ColumnLayout {
                id: menuColumn
                anchors.margins: 8
                spacing: 4
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: menus.children

                    delegate: Loader {
                        id: entryLoader
                        required property QsMenuEntry modelData
                        property bool submenuOpen: false

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
                            ColumnLayout {
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
                                            entryLoader.modelData.triggered();
                                            root.requestClose();
                                        } else {
                                            entryLoader.submenuOpen = !entryLoader.submenuOpen;
                                        }
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
                                        isVisible: entryLoader.submenuOpen
                                        onRequestClose: {
                                            entryLoader.submenuOpen = false;
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
}
