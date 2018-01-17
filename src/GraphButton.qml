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
        border.color: isActive ? "blue" : "gray"
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
        input3.forceActiveFocus()
        rect3.visible = false
        graphRect.visible = true
        parametersButton.isPressed = false
        tableButton.isPressed = false
        rect2Button.isPressed = false
        isPressed = true
        parser.functionString = parametersRect.input1.input.text
        parser.xStart = parseFloat(parametersRect.input2.input.text)
        parser.xEnd = parseFloat(parametersRect.endX.input.text)
        parser.yStart = parseFloat(parametersRect.minimumY.input.text)
        parser.yEnd = parseFloat(parametersRect.maximumY.input.text)
        parser.h = parseFloat(parametersRect.step.input.text)
        graphSignal()
        canvas.xStart = parseFloat(parametersRect.input2.input.text)
        canvas.xEnd = parseFloat(parametersRect.endX.input.text)
        canvas.yStart = parseFloat(parametersRect.minimumY.input.text)
        canvas.yEnd = parseFloat(parametersRect.maximumY.input.text)
        canvas.h = parseFloat(parametersRect.step.input.text)
        canvas.visible = true
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
