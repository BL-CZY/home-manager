pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../constants.js" as Constants

Scope {
    id: root

    property string time
    property string bat_percentage
    property string bat_status

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

                color: Constants.background

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: Constants.top_pad - 10

                RowLayout {
                    spacing: 10
                    anchors.centerIn: parent
                    width: parent.width

                    RowLayout {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        Layout.preferredWidth: 1
                        layoutDirection: Qt.LeftToRight
                        spacing: 20

                        Text {
                            id: placeholder
                            text: "󱄅 "
                            font.pixelSize: 24
                            color: "#4dd8ff"
                            horizontalAlignment: Text.Left
                            verticalAlignment: Text.AlignVCenter
                        }

                        Workspaces {}
                    }

                    Text {
                        id: clock
                        text: root.time
                        Layout.fillWidth: true
                        Layout.preferredWidth: 1
                        color: Constants.text
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.preferredWidth: 1
                        layoutDirection: Qt.RightToLeft

                        Bat {}
                    }
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

    Process {
        id: bat_proc

        running: true

        command: ["sh", "-c", "echo $(( $(cat /sys/class/power_supply/BAT1/energy_now) * 100 / $(cat /sys/class/power_supply/BAT1/energy_full) ))"]

        stdout: StdioCollector {
            onStreamFinished: root.bat_percentage = this.text
        }
    }

    Timer {
        interval: 10000

        running: true

        repeat: true

        onTriggered: bat_proc.running = true
    }
}
