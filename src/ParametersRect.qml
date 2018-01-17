import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Rectangle {
    id: root

    property alias input1: input1
    property alias input2: input2
    property alias endX: endX
    property alias minimumY: minimumY
    property alias maximumY: maximumY
    property alias step: step


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
                KeyNavigation.tab: checkboxDrawLine
                onActiveFocusChanged: {
                    if (activeFocus)
                        androidClient.speak(qsTr("End at: ") + text)
                }
            }
        }
        Row {
            //                Label {
            //                    height: 20
            //                    text: qsTr("Step:")
            //                }
            CheckBox {
                id: checkboxDrawLine
                height: 20
                text: "Draw line"
                checked: false
                KeyNavigation.tab: parametersButton
                //width: parent.width
                onCheckedChanged: canvas.drawLinesEnabled = checked
            }
        }
    }
}
