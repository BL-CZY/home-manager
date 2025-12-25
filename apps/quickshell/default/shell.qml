import Quickshell
import QtQuick
import qs.bar
import qs.misc
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

                        ctx.fillStyle = Constants.background;
                        ctx.strokeStyle = Constants.surface1; // Set your border color here
                        ctx.lineWidth = 2;           // Set border thickness

                        var x = 0, y = 0, w = width, h = height, r = 20;

                        // Adjust x, y, w, h slightly if you want the border to stay
                        // strictly inside the canvas boundaries
                        var lw = ctx.lineWidth;
                        var offset = lw / 2;
                        var adjX = x + offset;
                        var adjY = y + offset;
                        var adjW = w - lw;
                        var adjH = h - lw;

                        ctx.beginPath();
                        ctx.moveTo(adjX + r, adjY);
                        ctx.lineTo(adjX + adjW - r, adjY);
                        ctx.arcTo(adjX + adjW, adjY, adjX + adjW, adjY + r, r);
                        ctx.lineTo(adjX + adjW, adjY + adjH - r);
                        ctx.arcTo(adjX + adjW, adjY + adjH, adjX + adjW - r, adjY + adjH, r);
                        ctx.lineTo(adjX + r, adjY + adjH);
                        ctx.arcTo(adjX, adjY + adjH, adjX, adjY + adjH - r, r);
                        ctx.lineTo(adjX, adjY + r);
                        ctx.arcTo(adjX, adjY, adjX + r, adjY, r);
                        ctx.closePath();

                        // 1. Fill the shape
                        ctx.globalCompositeOperation = "xor";
                        ctx.fillRect(0, 0, width, height); // This uses your XOR logic
                        ctx.fill();

                        // 2. Draw the border
                        ctx.globalCompositeOperation = "source-over"; // Reset to normal drawing
                        ctx.stroke();
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

        color: Constants.background

        implicitWidth: Constants.pad
    }

    PanelWindow {
        anchors {
            top: true
            right: true
            bottom: true
        }

        color: Constants.background

        implicitWidth: Constants.pad
    }

    PanelWindow {
        anchors {
            left: true
            right: true
            bottom: true
        }

        color: Constants.background

        implicitHeight: Constants.pad
    }

    Bar {}
    Volume {}
    Brightness {}
}
