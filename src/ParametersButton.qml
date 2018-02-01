import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Button {
    id: root
    width: parent.width
    property bool isActive: true
    property bool isPressed: true

    contentItem: Text {
        id: buttonText
        text: qsTr("Function\nparameters")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 25
        color: setTextColor()
        anchors.fill: parent
        antialiasing: true
    }

    background: Rectangle {
        implicitHeight: 100
        radius: 10
        border.color: setBorderColor()
        color: isPressed ? "lightblue": "white"
        border.width: 5
    }

    onClicked: {
        isPressed = true
        graphButton.isPressed = false
        tableButton.isPressed = false
        rect2Button.isPressed = false
        parametersRect.visible = true
        parametersRect.input1.forceActiveFocus()
        rect2.visible = false
        rect3.visible = false
        graphRect.visible = false
    }

    onFocusChanged: {
        if (activeFocus) {
            isActive = true
            androidClient.speak(qsTr("Parameters button"))
        }
        else {
            isActive = false
        }
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

    function setBorderColor() {
        if (isActive)
            return "red"
        else
            return "gray"
    }

    Component.onCompleted: {
        isActive = true
        isPressed = true
    }
}
