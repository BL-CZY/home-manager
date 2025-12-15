import Quickshell
import QtQuick
import "constants.js" as Constants

Scope {
    id: root

    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }

                exclusiveZone: 0
                color: "transparent"

                mask: Region {
                    item: roundedRect
                    intersection: Intersection.Xor
                }

                Rectangle {
                    id: roundedRect
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    color: "transparent"
                }

                Canvas {
                    id: canvas
                    anchors.fill: parent

                    Component.onCompleted: requestPaint()

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.clearRect(0, 0, width, height);

                        ctx.fillStyle = "white";

                        ctx.globalCompositeOperation = "xor";

                        var x = 0, y = 0, w = width - x * 2, h = height - y, r = 20;

                        ctx.beginPath();
                        ctx.moveTo(x + r, y);
                        ctx.lineTo(x + w - r, y);
                        ctx.arcTo(x + w, y, x + w, y + r, r);
                        ctx.lineTo(x + w, y + h - r);
                        ctx.arcTo(x + w, y + h, x + w - r, y + h, r);
                        ctx.lineTo(x + r, y + h);
                        ctx.arcTo(x, y + h, x, y + h - r, r);
                        ctx.lineTo(x, y + r);
                        ctx.arcTo(x, y, x + r, y, r);
                        ctx.closePath();

                        ctx.fillRect(0, 0, width, height);

                        ctx.fill();
                    }
                }
            }
        }
    }

    PanelWindow {
        anchors {
            top: true
            left: true
            bottom: true
        }

        implicitWidth: Constants.pad
    }

    PanelWindow {
        anchors {
            top: true
            right: true
            bottom: true
        }

        implicitWidth: Constants.pad
    }

    PanelWindow {
        anchors {
            left: true
            right: true
            bottom: true
        }

        implicitHeight: Constants.pad
    }

    Bar {}
}
