pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import "constants.js" as Constants

Scope {
    id: root

    property string time

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: Constants.top_pad - 10

                Text {
                    id: clock
                    anchors.centerIn: parent
                    text: root.time
                }
            }
        }
    }

    Process {
        id: date_proc
        command: ["date"]

        running: true

        stdout: StdioCollector {
            onStreamFinished: root.time = this.text
        }
    }

    Timer {
        interval: 1000

        running: true

        repeat: true

        onTriggered: date_proc.running = true
    }
}
