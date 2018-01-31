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
            text: qsTr("Show\nrect2")
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

    onClicked: rect2ButtonPressed()

    onFocusChanged: {
        if (activeFocus) {
            isActive = true
            androidClient.speak(qsTr("Show rect2 button"))
        }
        else {
            isActive = false
        }
    }

    function rect2ButtonPressed() {
        parametersRect.visible = false
        rect2.visible = true
        rect2.input3.forceActiveFocus()
        rect3.visible = false
        graphRect.visible = false
        parametersButton.isPressed = false
        graphButton.isPressed = false
        tableButton.isPressed = false
        isPressed = true
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
