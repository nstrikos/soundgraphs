import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id: root

    property alias input1: functionInput
    property alias input2: startXInput
    property alias endX: endXInput
    property alias minimumY: minimumYInput
    property alias maximumY: maximumYInput
    property alias step: stepInput

    property int spacing: 5


    color: "white"
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: buttonsRect.right
    anchors.right: parent.right
    visible: true
    Column {
        spacing: spacing
        anchors.fill: parent
        TextEditLayout {
            id: functionInput
            labelText: qsTr("Function")
            input.text: "sin(x)"
            KeyNavigation.tab: startXInput
        }
        TextEditLayout {
            id: startXInput
            labelText: qsTr("Start at:")
            input.text: "-10"
            KeyNavigation.tab: endXInput
        }
        TextEditLayout {
            id: endXInput
            labelText: qsTr("End at:")
            input.text: "10"
            KeyNavigation.tab: minimumYInput
        }
        TextEditLayout {
            id: minimumYInput
            labelText: qsTr("Minimum Y:")
            input.text: "-10"
            KeyNavigation.tab: maximumYInput
        }
        TextEditLayout {
            id: maximumYInput
            labelText: qsTr("Maximum Y:")
            input.text: "10"
            KeyNavigation.tab: stepInput
        }
        TextEditLayout {
            id: stepInput
            labelText: qsTr("Step:")
            input.text: "0.1"
            KeyNavigation.tab: checkboxDrawLine
        }

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
