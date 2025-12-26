pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import "../constants.js" as Constants

Item {
    id: root
    required property QsMenuHandle menu
    required property bool isVisible
    signal requestClose

    // Calculate dimensions for the parent window to wrap around
    implicitWidth: isVisible ? menuColumn.implicitWidth + 16 : 0
    implicitHeight: isVisible ? menuColumn.implicitHeight + 16 : 0

    QsMenuOpener {
        id: menus
        menu: root.menu
    }

    ColumnLayout {
        id: menuColumn
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4
        visible: root.isVisible

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
                        implicitHeight: 1
                        color: Constants.surface1
                        opacity: 0.5
                        Layout.fillWidth: true
                        Layout.topMargin: 4
                        Layout.bottomMargin: 4
                    }
                }

                Component {
                    id: entry
                    MouseArea {
                        id: mouseArea
                        implicitWidth: entryLayout.implicitWidth + 40 // Extra space for arrow
                        implicitHeight: 32
                        hoverEnabled: true

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

                        // --- THE RECURSION LOGIC ---
                        // We load the WINDOW container, which inside contains THIS file
                        Loader {
                            id: submenuLoader
                            active: mouseArea.containsMouse && entryLoader.modelData.hasChildren
                            source: "SubMenuWindow.qml"
                            onLoaded: {
                                item.menu = entryLoader.modelData; // Pass the entry as the handle
                                item.parentPtr = mouseArea;        // Pass ref for positioning
                                item.requestClose.connect(root.requestClose);
                            }
                        }

                        onClicked: {
                            if (!entryLoader.modelData.hasChildren) {
                                entryLoader.modelData.triggered();
                                root.requestClose();
                            }
                        }
                    }
                }
            }
        }
    }
}
