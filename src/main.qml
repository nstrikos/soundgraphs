import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    signal graphSignal()

    property alias inputFunction: controlsContainer.inputFunction
    property alias xStart: controlsContainer.xStart
    property alias xEnd: controlsContainer.xEnd
    property alias yStart: controlsContainer.yStart
    property alias yEnd: controlsContainer.yEnd
    property alias h: controlsContainer.h
    property alias drawLinesEnabled: controlsContainer.drawLinesEnabled

    property bool firstRunning: false

    ButtonsContainer {
        id: buttonsContainer
    }

    ControlsContainer {
        id: controlsContainer
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: buttonsContainer.right
            right: parent.right
        }

        onGraphButtonPressed: {
            parser.functionString = inputFunction
            parser.xStart = xStart
            parser.xEnd = xEnd
            parser.yStart = yStart
            parser.yEnd = yEnd
            parser.h = h
            graphSignal()
            controlsContainer.visible = false
            canvas.visible = true
        }
    }

    FocusScope {
        id: focusScope
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: buttonsContainer.right
        }
        KeyNavigation.tab: buttonsContainer.test

        MyCanvas {
            id: canvas
            visible: false
            anchors.fill: parent
            MouseArea {
                id: mouseArea
                anchors.fill: parent

                onPressed: {
                    canvas.mousePressed(mouseX, mouseY)
                    androidClient.speak(mouseX)
                    //androidClient.vibrate(mouseX)
                    controlsContainer.visible = true
                    canvas.visible = false
                }
                onReleased: {
                    androidClient.vibrate(mouseX)
                }
            }
        }
    }

    TableView {
        id: tableView
    }

    function updatePoints() {
        canvas.updatePoints()
        focusScope.forceActiveFocus()
    }

    onDrawLinesEnabledChanged: canvas.drawLinesEnabled = drawLinesEnabled

}
