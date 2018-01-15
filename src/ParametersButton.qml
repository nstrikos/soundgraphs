import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Button {
    id: root
    width: parent.width
    property bool isActive: true
    property bool isPressed: false

    contentItem: Text {
        Text {
         text: qsTr("Function\nparameters")
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

    onClicked: {
        isPressed = true
        rect1.visible = true
        input1.forceActiveFocus()
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
}
