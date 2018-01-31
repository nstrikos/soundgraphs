import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

RowLayout {

    property alias text: label.text
    property bool isActive: false
    property bool isPressed: false

    width: parent.width

    Rectangle {
        Layout.minimumWidth: 150
        Label {
            id: label
            text: text
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    Button {
        id: button
        width: parent.width
        Layout.fillWidth: true

        contentItem: Text {
            id: buttonText
            text: isPressed ? "On" : "Off"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            anchors.fill: parent
            antialiasing: true
        }

        background: Rectangle {
            implicitHeight: 50
            radius: 10
            border.color: isActive ? "red" : "gray"
            color: isPressed ? "lightblue": "lightgray"
            border.width: isActive ? 5 : 2
        }

        onClicked: {
            isPressed = !isPressed
            speak()
        }

        onFocusChanged: {
            if (activeFocus) {
                isActive = true
                speak()
            }
            else {
                isActive = false
            }
        }

        Keys.onBacktabPressed: {
            stepInput.forceActiveFocus()
        }

        function speak() {
            var state = qsTr("Off")
            if (isPressed)
                state = qsTr("On")
            androidClient.speak(qsTr("Check button") + " " + label.text + " " + state)
        }

        Component.onCompleted: {
            isActive = false
            isPressed = false
        }
    }

    onActiveFocusChanged: {
        if (activeFocus)
            button.forceActiveFocus()
    }
}
