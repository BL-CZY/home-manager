pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Wayland
import "./scripts.js" as Scripts
import "../constants.js" as Constants

Scope {
    id: root

    property bool shouldBeVisible: false
    // property bool shouldBeVisible: true

    property int volume: 0
    property bool isMuted: false

    IpcHandler {
        target: "volume"
        function open(): void {
            root.shouldBeVisible = true;
            timer.running = false;
            timer.running = true;
        }

        function increase(): void {
            open();
            inc_volume.running = true;
        }

        function decrease(): void {
            open();
            dec_volume.running = true;
        }

        function toggleMute(): void {
            open();
            toggle_mute.running = true;
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
                    color: Constants.background
                    radius: 12
                    border.color: Constants.surface1
                    border.width: 1

                    // Add a drop shadow effect or blur if needed
                    implicitWidth: layout.implicitWidth + 40
                    implicitHeight: layout.implicitHeight + 20

                    RowLayout {
                        id: layout
                        anchors.centerIn: parent
                        spacing: 15

                        IconImage {
                            source: Quickshell.iconPath(Scripts.getVolumeIcon(root.volume, root.isMuted))
                            implicitWidth: 22
                            implicitHeight: 22
                        }

                        ProgressBar {
                            id: control
                            value: root.volume / 100
                            implicitWidth: 120
                            implicitHeight: 6

                            // Custom styling for the Progress Bar
                            background: Rectangle {
                                implicitWidth: 180
                                implicitHeight: 6
                                color: Constants.surface0
                                radius: 3
                            }

                            contentItem: Item {
                                implicitWidth: 180
                                implicitHeight: 6

                                Rectangle {
                                    width: control.visualPosition * parent.width
                                    height: parent.height
                                    radius: 3
                                    color: Constants.green
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
                            text: root.volume + "%"
                            color: Constants.text
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
        id: get_volume

        running: true

        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.volume = Number(this.text.trim().split(" ")[1]) * 100;

                if (this.text.indexOf("MUTED") !== -1) {
                    root.isMuted = true;
                } else {
                    root.isMuted = false;
                }
            }
        }
    }

    Process {
        id: inc_volume

        running: false

        command: ["wpctl", "set-volume", "-l", "1", "@DEFAULT_AUDIO_SINK@", "5%+"]

        stdout: StdioCollector {
            onStreamFinished: {
                get_volume.running = true;
            }
        }
    }

    Process {
        id: dec_volume

        running: false

        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"]

        stdout: StdioCollector {
            onStreamFinished: get_volume.running = true
        }
    }

    Process {
        id: toggle_mute

        running: false

        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", root.isMuted ? "0" : "1"]

        stdout: StdioCollector {
            onStreamFinished: get_volume.running = true
        }
    }
}
