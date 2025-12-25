pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import "./scripts.js" as Scripts

Scope {
    id: root

    // property bool shouldBeVisible: false
    property bool shouldBeVisible: true

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

                visible: root.shouldBeVisible
                RowLayout {
                    Text {
                        text: root.volume
                    }

                    IconImage {
                        source: Quickshell.iconPath(Scripts.getVolumeIcon(root.volume, root.isMuted))
                        implicitWidth: 24
                        implicitHeight: 24
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
