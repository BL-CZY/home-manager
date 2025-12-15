import QtQuick
import QtQuick.Effects
import Quickshell

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Rectangle {
                required property var modelData
                screen: modelData

                anchors {}
            }
        }
    }
}
