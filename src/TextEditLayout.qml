import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

RowLayout {

    property alias labelText: label.text
    property alias input: input

    Rectangle {
        Layout.fillWidth: true
        Layout.minimumWidth: 100
        Layout.preferredWidth: 100
        Layout.preferredHeight: 40
        Label {
            id: label
            text: qsTr("Function")
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }
    Rectangle {
        id: textRect
        border.color: "gray"
        border.width: 5
        radius: 10
        Layout.minimumWidth: 100
        Layout.preferredWidth: root.width - label.width - spacing
        Layout.preferredHeight: 100
        TextInput {
            id: input
            focus: true
            width: parent.width - spacing * 2
            clip: true
            anchors.centerIn: parent
            //KeyNavigation.tab: input2
            text: qsTr("sin(x)")
            font.pixelSize: 30
            onActiveFocusChanged: {
                if (activeFocus) {
                    textRect.border.color = "blue"
                    androidClient.speak(qsTr("Function ") + text)
                }
                else
                {
                    textRect.border.color = "gray"
                }
            }
        }
    }

    onFocusChanged: {
        if (activeFocus)
            input.forceActiveFocus()
    }
}