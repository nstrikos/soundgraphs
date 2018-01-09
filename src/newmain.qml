import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Sound graphs")

    signal graphSignal()

    Rectangle {
        id: buttonsRect
        width: 200
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: "lightgray"
        Column {
            anchors.fill: parent
            spacing: 5
            Button {
                id: parametersButton
                width: parent.width
                text: qsTr("Function parameters")
                onClicked: {
                    rect1.visible = true
                    input1.forceActiveFocus()
                    rect2.visible = false
                    rect3.visible = false
                    graphRect.visible = false
                }
                onActiveFocusChanged: {
                    if (activeFocus)
                        androidClient.speak(qsTr("Parameters button"))
                }
            }

            Button {
                id: graphButton
                width: parent.width
                text: qsTr("Show graph")
                onClicked: graphButtonPressed()

                onActiveFocusChanged: {
                    if (activeFocus)
                        androidClient.speak(qsTr("Graph button"))
                }
            }

            Button {
                id: rect2Button
                width: parent.width
                text: qsTr("Show rect2")
                onClicked: {
                    rect1.visible = false
                    rect2.visible = true
                    input3.forceActiveFocus()
                    rect3.visible = false
                    graphRect.visible = false
                }
                onActiveFocusChanged: {
                    if (activeFocus)
                        androidClient.speak(qsTr("Show rect2 button"))
                }
            }

            Button {
                id: tableButton
                width: parent.width
                text: qsTr("Table")
                KeyNavigation.tab: buttonNextTab()
                onClicked: {
                    rect1.visible = false
                    rect2.visible = false
                    rect3.visible = true
                    input5.forceActiveFocus()
                    graphRect.visible = false
                }
                onActiveFocusChanged: {
                    if (activeFocus)
                        androidClient.speak(qsTr("Table button"))
                }
            }
        }
    }

    Rectangle {
        id: rect1
        color: "lightblue"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: buttonsRect.right
        anchors.right: parent.right
        visible: true
        Column {
            spacing: 5
            anchors.fill: parent
            Row {
                Label {
                    height: 20
                    text: qsTr("Function")
                }
                LineEdit {
                    id: input1
                    KeyNavigation.tab: input2
                    text: qsTr("sin(x)")
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak(qsTr("Function ") + text)
                    }
                }
            }
            Row {
                Label {
                    height: 20
                    text: qsTr("Start at:")
                }
                LineEdit {
                    id: input2
                    text: qsTr("-10")
                    KeyNavigation.tab: endX
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak(qsTr("Start at: ") + text)
                    }
                }
            }
            Row {
                Label {
                    height: 20
                    text: qsTr("End at:")
                }
                LineEdit {
                    id: endX
                    text: qsTr("10")
                    KeyNavigation.tab: minimumY
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak(qsTr("End at: ") + text)
                    }
                }
            }
            Row {
                Label {
                    height: 20
                    text: qsTr("Minimum Y:")
                }
                LineEdit {
                    id: minimumY
                    text: qsTr("-10")
                    KeyNavigation.tab: maximumY
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak(qsTr("End at: ") + text)
                    }
                }
            }
            Row {
                Label {
                    height: 20
                    text: qsTr("Maximum Y:")
                }
                LineEdit {
                    id: maximumY
                    text: qsTr("10")
                    KeyNavigation.tab: step
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak(qsTr("End at: ") + text)
                    }
                }
            }
            Row {
                Label {
                    height: 20
                    text: qsTr("Step:")
                }
                LineEdit {
                    id: step
                    text: qsTr("0.1")
                    KeyNavigation.tab: parametersButton
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak(qsTr("End at: ") + text)
                    }
                }
            }
        }
    }


    Rectangle {
        id: graphRect
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: buttonsRect.right
        anchors.right: parent.right
        visible: false
        color: "lightgreen"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("mousearea clicked")
            }
        }
        MyCanvas {
            id: canvas
            visible: false
            anchors.fill: parent

        }
    }

    //    Rectangle {
    //        id: rect1
    //        width: 200
    //        anchors {
    //            top: parent.top
    //            bottom: parent.bottom
    //            left: parent.left
    //        }

    //        color: "pink"

    //        LineEdit {
    //            id: input1
    //            anchors {
    //                top: parent.top
    //                left: parent.left
    //            }
    //            width: 80
    //            height: 20
    //            text: "Input 1"
    //            KeyNavigation.tab: input2
    //            Accessible.role: Accessible.EditableText
    //            //Accessible.name: "Input"
    //            Accessible.description: "Insert value"
    //            onActiveFocusChanged: {
    //                if (activeFocus)
    //                    androidClient.speak("Input 1 " + text)
    //            }
    //        }

    //        LineEdit {
    //            id: input2
    //            x: 8; y: 36
    //            width: 96; height: 20
    //            text: "Text Input 2"
    //            KeyNavigation.tab: button1
    //            Accessible.role: Accessible.EditableText
    //            //Accessible.name: "Input"
    //            Accessible.description: "Insert second value"
    //            onActiveFocusChanged: {
    //                if (activeFocus)
    //                    androidClient.speak("Input 2 " + text)
    //            }
    //        }

    //        Button {
    //            id: button1
    //            anchors.top: input2.bottom
    //            //KeyNavigation.tab: input3
    //            KeyNavigation.tab: buttonNextTab()
    //            onClicked: {
    //                if (rect2.visible) {
    //                    rect2.visible = false
    //                    rect3.visible = true
    //                }
    //                else {
    //                    rect2.visible = true
    //                    rect3.visible = false
    //                }

    //            }
    //            Accessible.role: Accessible.defaultButton
    //            Accessible.name: "Button"
    //            Accessible.description: "Push button"
    //            onActiveFocusChanged: {
    //                if (activeFocus)
    //                    androidClient.speak("Button 1")
    //            }
    //        }
    //    }


    Rectangle {
        id: rect2
        color: "linen"
        visible: false
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: buttonsRect.right
        }

        Column {
            spacing: 5
            anchors.fill: parent
            Row {
                Label {
                    height: 20
                    text: qsTr("Text:")
                }
                LineEdit {
                    id: input3
                    //x: 8; y: 8
                    //width: 96; height: 20
                    //focus: true
                    text: "Text Input 3"
                    KeyNavigation.tab: input4
                    Accessible.role: Accessible.EditableText
                    //Accessible.name: "Input"
                    Accessible.description: "Insert third value"
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak("Input 3 " + text)
                    }
                }
            }
            Row {
                Label {
                    text: qsTr("Text")
                    height: 20
                }
                LineEdit {
                    id: input4
                    //x: 8; y: 36
                    //width: 96; height: 20
                    text: "Text Input 4"
                    KeyNavigation.tab: parametersButton
                    //Accessible.role: Accessible.editable
                    //Accessible.name: "Input"
                    Accessible.description: "Insert fourth value"
                    onActiveFocusChanged: {
                        if (activeFocus)
                            androidClient.speak("Input 4 " + text)
                    }
                }
            }
        }
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
                KeyNavigation.tab: parametersButton
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

    function buttonNextTab() {
        if (rect1.visible)
            return input1
        else if (rect2.visible)
            return input3
        else
            return input5
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
        canvas.visible = true
    }

    function updatePoints() {
        canvas.updatePoints()
        //focusScope.forceActiveFocus()
    }
}
