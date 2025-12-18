pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick

Scope {
    id: root

    property bool shouldBeVisible: false

    IpcHandler {
        target: "volume"
        function open(): void {
            root.shouldBeVisible = true;
            timer.running = false;
            timer.running = true;
        }
    }

    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                visible: root.shouldBeVisible
                Text {
                    text: "TEST"
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
}
