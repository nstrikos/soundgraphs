import QtQuick 2.9
import QtQml 2.2

//What needs to be done
//--> find where the function is not continuous
//--> precision
//--> javascript has infinity
//--> check if xEnd > xStart, yEnd > yStart
//--> sin(x)/x at x = 0 the func gives 3.28????
//--> autoadjust height finding min and max
//--> announce when graph is completed
//--> put func computation to different thread, does this the problem of resizing in large inputs?

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
    property var xPixelPosition: [] //Store x screen coordinates
    property var yPixelPosition:[]  //Store y screen coordinates
    property real lineWidth: 2
    property bool drawLinesEnabled: false
    property real distance

    function paintCanvas() {


        initializeCanvas()
        initializeArrays()
        //calculateActualCoordinates()
        calculateScreenCoordinates()
        draw()
    }

    function initializeCanvas() {
        ctx = canvas.getContext("2d")
        if (canvas.width > 0 && canvas.height > 0) { //There is a problem initializing canvas, that's why we use canvasDataAreValidVariable
            canvasDataAreValid = true
            canvasData = ctx.createImageData(canvas.width, canvas.height)
            ctx.reset()
            ctx.clearRect(0, 0, canvas.width, canvas.height)
        }
    }

    function initializeArrays() {
        //xPoints.length = 0
        //yPoints.length = 0
        xPixelPosition.length = 0
        yPixelPosition.length = 0
    }

    function calculateActualCoordinates() {
        h = strip(h)
        for (var x = xStart; x < xEnd; x += h) {
            var variable = strip(x)
            xPoints.push(variable)
            yPoints.push(strip(func(variable)))
        }
    }

    function calculateScreenCoordinates() {
        for (var i = 0; i < xPoints.length; i++) {
            var x =  Math.round( strip( canvas.width / (xEnd - xStart) * (xPoints[i] - xStart) ) )
            var y = Math.round( strip(canvas.height / (yEnd - yStart) * (yPoints[i] - yStart) ) )
            y = canvas.height - y
            xPixelPosition.push(x)
            yPixelPosition.push(y)
        }
    }

    function draw() {
        if (drawLinesEnabled)
            drawLines()
        else
            drawPixels()
    }

    function drawPixels() {
        if (canvasDataAreValid) {
            for ( var i = 0; i < xPixelPosition.length; i++) {
                var y = yPixelPosition[i]
                var x = xPixelPosition[i]
                var idx = (x + y * canvas.width) * 4

                // Update the values of the pixel;
                canvasData.data[idx + 0] = 255
                canvasData.data[idx + 1] = 0
                canvasData.data[idx + 2] = 0
                canvasData.data[idx + 3] = 255
            }
            ctx.drawImage(canvasData, 0, 0)
            requestPaint()
        }
    }

    function drawLines() {
        var x,y
        //ctx.lineWidth = canvas.lineWidth
        ctx.lineWidth = 5
        // set line color
        ctx.strokeStyle = '#ff0000';
        ctx.beginPath()

        //Go to first point without drawing a line
        y = yPixelPosition[0]
        x = xPixelPosition[0]
        ctx.moveTo(x, y)

        //Begin drawing lines
        for (var i = 1; i < xPixelPosition.length; i++) {
            y = yPixelPosition[i]
            x = xPixelPosition[i]
            ctx.lineTo(x, y)
        }
        ctx.stroke()
        requestPaint()
    }

    function func(x) {
        var y = 50 * Math.sin(x) / x
        return y

    }

    function strip(number) {
        return (parseFloat(number).toPrecision(10));
    }

    function mousePressed(x, y)
    {
        console.log("Pressed at x:" + x + ", y:" + y)
        var ctx = canvas.getContext("2d")
        ctx.fillStyle = "#33a9ff"
        ctx.beginPath()
        ctx.arc(x, y, 5, 0, 2*Math.PI)
        ctx.closePath()
        ctx.fill()
        canvas.requestPaint();
    }

    //onXStartChanged: paintCanvas()
    //onXEndChanged: paintCanvas()
    //onYStartChanged: paintCanvas()
    //onYEndChanged: paintCanvas()
    //onDrawLinesEnabledChanged: paintCanvas()

    //Neither Component.onCompleted works nor onAvailableChanged
    //Component.onCompleted ctx points to null
    //onAvailableChanged height is zero

    //Works for android
    onAvailableChanged: paintCanvas()

    //Works for linux
    onHeightChanged: paintCanvas()
    onWidthChanged: {
        if (canvasDataAreValid)
            paintCanvas()
    }

    function updatePoints() {
        xStart = parser.xStart
        xEnd = parser.xEnd
        yStart = parser.yStart
        yEnd = parser.yEnd
        h = parser.h
        xPoints = parser.xPoints
        yPoints = parser.yPoints
        drawCoordinates()
        paintCanvas()
    }

    function drawCoordinates() {
        console.log("Drawing coordinates")
        console.log("xStart: " + xStart)
        console.log("xEnd: " + xEnd)
        console.log("yStart: " + yStart)
        console.log("yEnd: " + yEnd)
        console.log("h: " + h)

        var max = 20 //Maximum twenty lines
        var min = 10 //Minimum ten lines
        var l = xEnd - xStart
        console.log("Length (l) is: " + l)

        var d = 1 //Starting distance
        console.log("Starting distance (d): " + d)

        var n = l / d
        if (d < l / max) {
            dMax(d, l, max, min)
            findGridLines(xStart, xEnd, distance)
        }
        else if ( d >= l/max  && d <= l/min) {
            console.log("Found d: " + d)
            findGridLines(xStart, xEnd, distance)
        }
        else {
            dMin(d, l, max, min)
            findGridLines(xStart, xEnd, distance)
        }
    }

    function dMin(d, l, max, min) {
        console.log("We have to make d smaller: " + d)
        var temp_d = d
        var f1 = l /max
        var f2 = l / min
        console.log("f1: " + f1 + " , f2:" + f2)
        if (temp_d - f1 >= 0.000001 && temp_d - f2 <= 0.000001) {
            console.log("We found d: " + temp_d)
            distance = temp_d
            return
        }
        else {
            temp_d = d / 2.0
            console.log(temp_d)
            if ( temp_d - f1 >= 0.000001 && temp_d - f2 <= 0.000001) {
                console.log("We found d: " + temp_d)
                distance = temp_d
                return
            }
            else {
                temp_d = d / 5.0
                console.log(temp_d)
                if ( temp_d - f1 >= 0.000001 && temp_d - f2 <= 0.000001) {
                    console.log("We found d: " + temp_d)
                    distance = temp_d
                    return
                }
                else {
                    temp_d = d / 10.0
                    dMin(temp_d, l , max,  min)
                }
            }
        }

    }

    function dMax(d, l, max, min) {
        console.log("We have to make d bigger: " + d)
        var temp_d = d
        if (temp_d >= l /max && temp_d <= l/min) {
            console.log("We found d: " + temp_d)
            distance = temp_d
            return
        }
        else {
            temp_d = 2 * d
            if ( temp_d >= l /max && temp_d <= l/min) {
                console.log("We found d: " + temp_d)
                distance = temp_d
                return
            }
            else {
                temp_d = 5 * d
                if ( temp_d >= l /max && temp_d <= l/min) {
                    console.log("We found d: " + temp_d)
                    distance = temp_d
                    return
                }
                else {
                    temp_d = 10 * d
                    dMax(temp_d, l , max,  min)
                }
            }
        }
    }

    function findGridLines(x0, x1, dl) {
        console.log(x0, x1, dl)
        var point = (x0 + dl)
        console.log("Start:" + point)
        point = point / dl
        console.log("Start:" + point)
        point = Math.floor(point)
        console.log("Start:" + point)
        point = point * dl
        console.log("Start:" + point)
        var done = false
        while (!done) {
            point += dl
            if (point < x1)
                console.log("Point: " + point)
            else
                done = true
        }
    }
}
