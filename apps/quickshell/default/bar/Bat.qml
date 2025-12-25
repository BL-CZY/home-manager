import Quickshell.Services.UPower
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import "bat.js" as Scripts
import "../constants.js" as Constants

Item {
    id: root

    property int percentage
    Layout.fillWidth: true

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        width: icon.implicitWidth + 20
        height: icon.implicitHeight
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            console.log("clicked");
        }

        Rectangle {
            anchors.fill: parent
            radius: 6
            color: mouseArea.containsMouse ? "#ff0000" : "transparent"

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }

        Text {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: Constants.text
            font.pixelSize: 20

            // I use the first battery because the 0th one is broken
            text: Scripts.percentage_to_icon(UPower.devices.values[1].percentage, UPower.onBattery)
        }

        ToolTip {
            visible: mouseArea.containsMouse
            text: Scripts.percentage(UPower.devices.values[1].percentage)
            delay: 500
        }
    }
}
