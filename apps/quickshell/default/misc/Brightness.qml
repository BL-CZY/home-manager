pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Wayland
import "./scripts.js" as Scripts

Scope {
    id: root

    property bool shouldBeVisible: false
    // property bool shouldBeVisible: true

    property int brightness: 0

    IpcHandler {
        target: "brightness"
        function open(): void {
            root.shouldBeVisible = true;
            timer.running = false;
            timer.running = true;
        }

        function increase(): void {
            open();
            inc_brightness.running = true;
        }

        function decrease(): void {
            open();
            dec_brightness.running = true;
        }
    }

    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                WlrLayershell.namespace: "osd"

                // Positioning
                anchors.bottom: true
                exclusiveZone: 0
                margins.bottom: 150 // Slightly higher for better visibility

                visible: root.shouldBeVisible
                implicitWidth: 250
                implicitHeight: 50

                color: "transparent"

                Rectangle {
                    anchors.centerIn: parent
                    color: Qt.rgba(0.1, 0.1, 0.1) // Dark translucent background
                    radius: 12
                    border.color: Qt.rgba(1, 1, 1, 0.1)
                    border.width: 1

                    // Add a drop shadow effect or blur if needed
                    implicitWidth: layout.implicitWidth + 40
                    implicitHeight: layout.implicitHeight + 20

                    RowLayout {
                        id: layout
                        anchors.centerIn: parent
                        spacing: 15

                        IconImage {
                            source: Quickshell.iconPath(Scripts.getBrightnessIcon(root.brightness))
                            implicitWidth: 22
                            implicitHeight: 22
                        }

                        ProgressBar {
                            id: control
                            value: root.brightness / 100
                            implicitWidth: 120
                            implicitHeight: 6

                            // Custom styling for the Progress Bar
                            background: Rectangle {
                                implicitWidth: 180
                                implicitHeight: 6
                                color: Qt.rgba(1, 1, 1, 0.1)
                                radius: 3
                            }

                            contentItem: Item {
                                implicitWidth: 180
                                implicitHeight: 6

                                Rectangle {
                                    width: control.visualPosition * parent.width
                                    height: parent.height
                                    radius: 3
                                    color: "#3498db" // Nice blue accent

                                    Behavior on width {
                                        NumberAnimation {
                                            duration: 150
                                            easing.type: Easing.OutCubic
                                        }
                                    }
                                }
                            }
                        }

                        Text {
                            text: root.brightness + "%"
                            color: "white"
                            font.pixelSize: 14
                            font.weight: Font.Medium
                            font.family: "Sans Serif"
                            horizontalAlignment: Text.AlignRight
                            Layout.preferredWidth: 35
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: timer
        running: false
        interval: 3000
        onTriggered: root.shouldBeVisible = false
    }

    Process {
        id: get_brightness

        running: true

        command: ["sh", "-c", "echo $(brightnessctl m):$(brightnessctl g)"]

        stdout: StdioCollector {
            onStreamFinished: {
                const values = this.text.split(":").map(Number);

                if (values.length === 2 && values[0] > 0) {
                    const [max, current] = values;
                    const percentage = current / max;

                    // The 4th root "linearization"
                    const rooted_percentage = (Math.pow(percentage, 0.25) * 100);
                    const rounded_percentage = Math.round(rooted_percentage / 5) * 5;
                    const displayed_percentage = Math.round((rounded_percentage - 20) / 0.8);

                    root.brightness = displayed_percentage;
                }
            }
        }
    }

    Process {
        id: inc_brightness

        running: false

        command: ["brightnessctl", "-e4", "-n2", "set", "5%+"]

        stdout: StdioCollector {
            onStreamFinished: {
                get_brightness.running = true;
            }
        }
    }

    Process {
        id: dec_brightness

        running: false

        command: ["brightnessctl", "-e4", "-n2", "set", "5%-"]

        stdout: StdioCollector {
            onStreamFinished: get_brightness.running = true
        }
    }
}
