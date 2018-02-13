import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Rectangle {
    id: graphRect

    property alias graphCanvas: graphCanvas

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: buttonsRect.right
    anchors.right: parent.right
    visible: false
    color: "white"
    MouseArea {
        anchors.fill: parent
        onPressed: {
            graphCanvas.mousePressed(mouseX, mouseY)
            androidClient.speak(mouseX)
            //androidClient.vibrate(mouseX)
            //controlsContainer.visible = true
            //canvas.visible = false
        }
        onReleased: {
            androidClient.vibrate(mouseX)
        }
    }
    GraphCanvas {
        id: graphCanvas
        visible: false
        anchors.fill: parent        
    }
}
