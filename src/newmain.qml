import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Window {
    visible: true
    width: 640
    height: 480
    minimumWidth: 450
    title: qsTr("Sound graphs")

    signal graphSignal()

    ButtonsRect {
        id: buttonsRect
    }

    ParametersRect {
        id: parametersRect
    }

    Rectangle {
        id: graphRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: buttonsRect.right
        anchors.right: parent.right
        visible: false
        color: "white"
        MouseArea {
            anchors.fill: parent
            onPressed: {
                canvas.mousePressed(mouseX, mouseY)
                androidClient.speak(mouseX)
                //androidClient.vibrate(mouseX)
                //controlsContainer.visible = true
                //canvas.visible = false
            }
            onReleased: {
                androidClient.vibrate(mouseX)
            }
        }
        MyCanvas {
            id: canvas
            visible: false
            anchors.fill: parent

        }
    }

    Rect2 {
        id: rect2
    }

    Rectangle {
        id: rect3
        visible: false
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: buttonsRect.right
        }
        color: "cyan"

        Column {

            LineEdit {
                id: input5
                x: 8; y: 8
                width: 96; height: 20
                //focus: true
                text: "Text Input 5"
                KeyNavigation.tab: input6
                Accessible.role: Accessible.EditableText
                //Accessible.name: "Input"
                Accessible.description: "Insert fifth value"
                onActiveFocusChanged: {
                    if (activeFocus)
                        androidClient.speak("Input 5 " + text)
                }
            }

            LineEdit {
                id: input6
                x: 8; y: 36
                width: 96; height: 20
                text: "Text Input 6"
                KeyNavigation.tab: buttonsRect.parametersButton
                Accessible.role: Accessible.EditableText
                //Accessible.name: "Input"
                Accessible.description: "Insert sixth value"
                onActiveFocusChanged: {
                    if (activeFocus)
                        androidClient.speak("Input 6 " + text)
                }
            }
        }
    }

    function updatePoints() {
        canvas.updatePoints()
        //focusScope.forceActiveFocus()
    }

    Component.onCompleted: {
        parametersRect.visible = true
        graphRect.visible = false
        rect2.visible = false
        rect3.visible = false
    }
}
