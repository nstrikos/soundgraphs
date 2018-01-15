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
        rect1.visible = false
        rect2.visible = true
        input3.forceActiveFocus()
        rect3.visible = false
        graphRect.visible = false
    }
}