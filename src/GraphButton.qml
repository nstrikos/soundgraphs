import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Button {
    id: root
    width: parent.width
    property bool isActive: false
    property bool isPressed: false

    contentItem: Text {
        Text {
            text: qsTr("Show\ngraph")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 25
            color: setTextColor()
            anchors.fill: parent
            antialiasing: true
        }
    }

    background: Rectangle {
        implicitHeight: 100
        radius: 10
        border.color: isActive ? "red" : "gray"
        color: isPressed ? "lightblue": "white"
        border.width: 5
    }

    onClicked: graphButtonPressed()

    onFocusChanged: {
        if (activeFocus) {
            isActive = true
            androidClient.speak(qsTr("Show graph button"))
        }
        else {
            isActive = false
        }
    }

    function graphButtonPressed() {
        parametersRect.visible = false
        rect2.visible = false
        rect3.visible = false
        graphRect.visible = true
        parametersButton.isPressed = false
        tableButton.isPressed = false
        rect2Button.isPressed = false
        isPressed = true
        graphRect.graphCanvas.drawLinesEnabled = parametersRect.checkDrawLine.isPressed
        parser.functionString = parametersRect.input1.input.text
        parser.xStart = parseFloat(parametersRect.input2.input.text)
        parser.xEnd = parseFloat(parametersRect.endX.input.text)
        parser.yStart = parseFloat(parametersRect.minimumY.input.text)
        parser.yEnd = parseFloat(parametersRect.maximumY.input.text)
        parser.h = parseFloat(parametersRect.step.input.text)
        graphSignal()
        graphRect.graphCanvas.xStart = parseFloat(parametersRect.input2.input.text)
        graphRect.graphCanvas.xEnd = parseFloat(parametersRect.endX.input.text)
        graphRect.graphCanvas.yStart = parseFloat(parametersRect.minimumY.input.text)
        graphRect.graphCanvas.yEnd = parseFloat(parametersRect.maximumY.input.text)
        graphRect.graphCanvas.h = parseFloat(parametersRect.step.input.text)
        graphRect.graphCanvas.visible = true
    }

    function setTextColor() {
        if (isActive) {
            if (isPressed)
                return "black"
            else
                return "gray"
        }
        else {
            if (isPressed)
                return "black"
            else
                return "gray"
        }
    }
}
