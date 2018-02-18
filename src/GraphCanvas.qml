import QtQuick 2.9
import QtQml 2.2

import "GraphCanvasJS.js" as CanvasJS
import "GraphCanvasMouseJS.js" as MouseJS

//What needs to be done
//--> find where the function is not continuous
//--> precision
//--> javascript has infinity
//--> check if xEnd > xStart, yEnd > yStart
//--> sin(x)/x at x = 0 the func gives 3.28????
//--> autoadjust height finding min and max
//--> announce when graph is completed
//--> put func computation to different thread, does this solve the problem of resizing in large inputs?

Canvas {
    id: canvas

    property color canvasColor: "#ffffff"

    property var ctx //Handle to canvas
    property var canvasData //canvas data for displaying pixels
    property bool canvasDataAreValid: false //Check if canvas is ready for drawing
    property real xStart: -2
    property real xEnd: 2
    property real yStart: -2
    property real yEnd: 2
    property real h: 0.1
    property var xPoints: [] //Store actual x values
    property var yPoints: [] //Store actual y values
    property var xScrCoords: [] //Store x screen coordinates
    property var yScrCoords:[]  //Store y screen coordinates
    property real lineWidth: 2
    property bool drawLinesEnabled: false
    property real distance
    property var xGrid: [] //Store actual x grid coordinates
    property var yGrid: [] //Store actual y grid coordiantes
    property var tempGrid: []
    property var xGridScrCoords: [] //Store x grid screen coordinates
    property var yGridScrCoords: [] //Store y grid screen coordinates

    function updatePoints() {
        CanvasJS.updatePoints()
    }

    function mousePressed(x, y) {
        MouseJS.mousePressed(x, y)
    }

    //Neither Component.onCompleted works nor onAvailableChanged
    //Component.onCompleted ctx points to null
    //onAvailableChanged height is zero

    //Works for android
    onAvailableChanged: CanvasJS.paintCanvas()

    //Works for linux
    onHeightChanged: CanvasJS.paintCanvas()
    onWidthChanged: {
        if (canvasDataAreValid)
            CanvasJS.paintCanvas()
    }
}
