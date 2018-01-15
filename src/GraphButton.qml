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
         color: isPressed ? "red" : "blue"
         anchors.fill: parent
         antialiasing: true
        }
    }

    background: Rectangle {
        implicitHeight: 100
        radius: 10
        border.color: isActive ? "blue" : "gray"
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
        rect1.visible = false
        rect2.visible = false
        input3.forceActiveFocus()
        rect3.visible = false
        graphRect.visible = true
        parser.functionString = input1.text
        parser.xStart = parseFloat(input2.text)
        parser.xEnd = parseFloat(endX.text)
        parser.yStart = parseFloat(minimumY.text)
        parser.yEnd = parseFloat(maximumY.text)
        parser.h = parseFloat(step.text)
        graphSignal()
        canvas.xStart = parseFloat(input2.text)
        canvas.xEnd = parseFloat(endX.text)
        canvas.yStart = parseFloat(minimumY.text)
        canvas.yEnd = parseFloat(maximumY.text)
        canvas.h = parseFloat(step.text)
        canvas.visible = true
    }
}
