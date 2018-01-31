import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Button {
    id: root
    width: parent.width
    KeyNavigation.tab: buttonNextTab()
    property bool isActive: false
    property bool isPressed: false

    contentItem: Text {
        Text {
            text: qsTr("Show\ntable")
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

    onClicked: tableButtonPressed()

    onFocusChanged: {
        if (activeFocus) {
            isActive = true
            androidClient.speak(qsTr("Show table button"))
        }
        else {
            isActive = false
        }
    }

    function tableButtonPressed() {
        parametersRect.visible = false
        rect2.visible = false
        rect3.visible = true
        input5.forceActiveFocus()
        graphRect.visible = false
        parametersButton.isPressed = false
        rect2Button.isPressed = false
        graphButton.isPressed = false
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

    function buttonNextTab() {
        if (parametersRect.visible)
            return parametersRect.input1
        else if (rect2.visible)
            return rect2.input3
        else
            return input5
    }
}
