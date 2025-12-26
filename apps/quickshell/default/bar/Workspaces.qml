import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root
    // Item needs a height for the layout to center vertically within it
    implicitHeight: 40
    Layout.fillWidth: true

    RowLayout {
        // This centers the entire row vertically within 'root'
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        spacing: 5
        layoutDirection: Qt.LeftToRight

        Repeater {
            model: Hyprland.workspaces

            delegate: MouseArea {
                required property var modelData
                Layout.preferredWidth: dot.implicitWidth
                Layout.preferredHeight: dot.implicitHeight
                Layout.alignment: Qt.AlignVCenter

                onClicked: {
                    modelData.activate();
                }

                Rectangle {
                    id: dot
                    anchors.centerIn: parent

                    implicitWidth: parent.modelData.active ? 70 : 15
                    implicitHeight: 15
                    radius: 100
                    color: parent.modelData.id < 0 ? "#03fc39" : parent.modelData.active ? "#4dd8ff" : "#7c008a"

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }

                    Behavior on implicitWidth {
                        NumberAnimation {
                            easing.type: Easing.OutExpo
                            duration: 700
                        }
                    }
                }
            }
        }
    }
}
