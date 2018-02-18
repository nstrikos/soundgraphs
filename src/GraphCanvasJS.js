function updatePoints()
{
    xStart = parser.xStart
    xEnd = parser.xEnd
    yStart = parser.yStart
    yEnd = parser.yEnd
    h = parser.h
    xPoints = parser.xPoints
    yPoints = parser.yPoints
    paintCanvas()
}

function paintCanvas()
{
    initializeCanvas()
    initializeArrays()
    calculateScreenCoords()
    draw()
}



function initializeCanvas()
{
    ctx = canvas.getContext("2d")
    if (canvas.width > 0 && canvas.height > 0) {
        //There is a problem initializing canvas, that's why we use canvasDataAreValid variable
        canvasDataAreValid = true
        canvasData = ctx.createImageData(canvas.width, canvas.height)
        ctx.reset()
        ctx.clearRect(0, 0, canvas.width, canvas.height)
    }
}

function initializeArrays()
{
    xPoints.lenth = 0
    yPoints.length = 0
    xScrCoords.length = 0
    yScrCoords.length = 0
    xGrid.length = 0
    yGrid.length = 0
    xGridScrCoords.length = 0
    yGridScrCoords.length = 0
    tempGrid.length = 0
}

function calculateScreenCoords()
{
    for (var i = 0; i < xPoints.length; i++) {
        var x =  Math.round( strip( canvas.width / (xEnd - xStart) * (xPoints[i] - xStart) ) )
        var y = Math.round( strip(canvas.height / (yEnd - yStart) * (yPoints[i] - yStart) ) )
        y = canvas.height - y
        xScrCoords.push(x)
        yScrCoords.push(y)
    }
}

function draw()
{
    if (drawLinesEnabled)
        drawLines()
    else
        drawPixels()
}

function drawPixels()
{
    if (canvasDataAreValid) {
        for ( var i = 0; i < xScrCoords.length; i++) {
            var y = yScrCoords[i]
            var x = xScrCoords[i]
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

function drawLines()
{
    ctx.beginPath()
    ctx.lineWidth = 4
    ctx.strokeStyle = '#000000'; // set line color
    var xAxes =  Math.round( strip( canvas.width / (xEnd - xStart) * (0 - xStart) ) )
    var yAxes = Math.round( strip(canvas.height / (yEnd - yStart) * (0 - yStart) ) )
    ctx.moveTo(xAxes, 0)
    ctx.lineTo(xAxes, canvas.height)
    ctx.moveTo(0, canvas.height - yAxes)
    ctx.lineTo(canvas.width, canvas.height - yAxes)
    //ctx.moveTo(xAxes, yAxes)
    //ctx.lineTo(xAxes, 0)
    ctx.stroke()

    var x,y
    //ctx.lineWidth = canvas.lineWidth
    ctx.lineWidth = 5
    // set line color
    ctx.strokeStyle = '#ff0000';
    ctx.beginPath()

    //Go to first point without drawing a line
    y = yScrCoords[0]
    x = xScrCoords[0]
    ctx.moveTo(x, y)

    //Begin drawing lines
    for (var i = 1; i < xScrCoords.length; i++) {
        y = yScrCoords[i]
        x = xScrCoords[i]
        ctx.lineTo(x, y)
    }
    ctx.stroke()

    drawCoordinates(xStart, xEnd, "x")
    xGridScrCoords = tempGrid
    ctx.beginPath()
    ctx.lineWidth = 0.1
    // set line color
    ctx.strokeStyle = '#000000';
    i = 0;
    while ( i < xGridScrCoords.length) {
        x = xGridScrCoords[i];
        //ctx.font = "30px Arial";
        ctx.fillStyle = "black";
        var round = Math.round (xGrid[i] / distance) * distance
        //round = parseFloat(round)
        var text = +parseFloat(round).toFixed(5)
        var w = ctx.measureText(text).width
        console.log(i, xGrid[i])
        if ( (x + w/2) >= canvas.width )
        {
            var pos = x - w/2 - 10
        }
        else if (x - w/2 <= 0) {
            console.log("Error: " + i)
            pos = 0
        }
        else
            pos = x - w/2
        ctx.fillText(text, pos, 10);
        ctx.moveTo(x, 0)
        ctx.lineTo(x, canvas.height)
        i++
    }

    drawCoordinates(yStart, yEnd, "y")
    yGridScrCoords = tempGrid
    i = 0;
    while ( i < yGridScrCoords.length) {
        y = yGridScrCoords[i];
        ctx.fillStyle = "black";
        round = Math.round (yGrid[i] / distance) * distance
        ctx.fillText(+parseFloat(round).toFixed(5), 0, canvas.height - y);
        ctx.moveTo(0, y)
        ctx.lineTo(canvas.width, y)
        i++
    }

    ctx.stroke()

    requestPaint()
}

function drawCoordinates(start, end, method) {

    tempGrid.length = 0

    var max = 20 //Maximum twenty lines
    var min = 10 //Minimum ten lines
    var l = end - start

    var d = 1 //Starting distance

    var n = l / d
    if (d < l / max) {
        dMax(d, l, max, min)
        findGridLines(start, end, distance, method)
    }
    else if ( d >= l/max  && d <= l/min) {
        distance = d
        findGridLines(start, end, distance, method)
    }
    else {
        dMin(d, l, max, min)
        findGridLines(start, end, distance, method)
    }
}

function strip(number) {
    return (parseFloat(number).toPrecision(10));
}

function dMin(d, l, max, min) {
    var temp_d = d
    var f1 = l /max
    var f2 = l / min
    if (temp_d - f1 >= 0.000001 && temp_d - f2 <= 0.000001) {
        distance = temp_d
        return
    }
    else {
        temp_d = d / 2.0
        if ( temp_d - f1 >= 0.000001 && temp_d - f2 <= 0.000001) {
            distance = temp_d
            return
        }
        else {
            temp_d = d / 5.0
            if ( temp_d - f1 >= 0.000001 && temp_d - f2 <= 0.000001) {
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
    var temp_d = d
    if (temp_d >= l /max && temp_d <= l/min) {
        distance = temp_d
        return
    }
    else {
        temp_d = 2 * d
        if ( temp_d >= l /max && temp_d <= l/min) {
            distance = temp_d
            return
        }
        else {
            temp_d = 5 * d
            if ( temp_d >= l /max && temp_d <= l/min) {
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

function findGridLines(x0, x1, dl, method) {
    var point = (x0)
    point = point / dl
    point = Math.floor(point)
    point = point * dl
    if (method === "x") {
        tempGrid.push(Math.round( strip( canvas.width / (xEnd - xStart) * (point - xStart) ) ))
        xGrid.push(point)
    }
    else {
        tempGrid.push(Math.round( strip(canvas.height / (yEnd - yStart) * (point - yStart) ) ))
        yGrid.push(point)
    }
//        point = (x0 + dl)
//        point = point / dl
//        point = Math.floor(point)
//        point = point * dl
//        if (method === "x") {
//            tempGrid.push(Math.round( strip( canvas.width / (xEnd - xStart) * (point - xStart) ) ))
//            xGrid.push(point)
//        }
//        else {
//            tempGrid.push(Math.round( strip(canvas.height / (yEnd - yStart) * (point - yStart) ) ))
//            yGrid.push(point)
//        }
    var done = false
    while (!done) {
        point += dl
        if (point < x1) {
            var screenPoint
            if (method === "x") {
                screenPoint =  Math.round( strip( canvas.width / (xEnd - xStart) * (point - xStart) ) )
                xGrid.push(point)
            }
            else {
                screenPoint = Math.round( strip(canvas.height / (yEnd - yStart) * (point - yStart) ) )
                yGrid.push(point)
            }
            tempGrid.push(screenPoint)
        }
        else {
            if (method === "x") {
                screenPoint =  Math.round( strip( canvas.width / (xEnd - xStart) * (point - xStart) ) )
                xGrid.push(point)
            }
            else {
                screenPoint = Math.round( strip(canvas.height / (yEnd - yStart) * (point - yStart) ) )
                yGrid.push(point)
            }
            tempGrid.push(screenPoint)
            return
        }
    }
}

function drawxGridScrCoordsLines() {
    var x,y
    //ctx.lineWidth = canvas.lineWidth
    ctx.lineWidth = 5
    // set line color
    ctx.strokeStyle = '#ff0000';
    ctx.beginPath()

    //        //Go to first point without drawing a line
    //        y = yScrCoords[0]
    //        x = xScrCoords[0]
    //        ctx.moveTo(x, y)

    //        //Begin drawing lines
    //        for (var i = 1; i < xScrCoords.length; i++) {
    //            y = yScrCoords[i]
    //            x = xScrCoords[i]
    //            ctx.lineTo(x, y)
    //        }
    //        ctx.stroke()
    var i = 0;
    while ( i < xGridScrCoords.length) {
        x = xGridScrCoords[i];
        ctx.moveTo(x, 0)
        ctx.lineTo(x, canvas.height)
        i++
    }

    requestPaint()
}


