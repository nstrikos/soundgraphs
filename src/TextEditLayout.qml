import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

RowLayout {

    property alias text: input.text
    property alias labelText: label.text
    property alias input: input

    width: parent.width

    Rectangle {
        Layout.minimumWidth: 150
        Label {
            id: label
            text: labelText
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }
    Rectangle {
        id: textRect
        border.color: "gray"
        border.width: 2
        radius: 10
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        Accessible.name: "test button"

        TextInput {
            id: input
            text: text
            focus: true
            clip: true
            anchors.centerIn: parent
            font.pixelSize: 20
            onActiveFocusChanged: {
                if (activeFocus) {
                    textRect.border.color = "red"
                    textRect.border.width = 5
                    androidClient.speak(label.text + input.text)
                }
                else {
                    textRect.border.color = "gray"
                    textRect.border.width = 2
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: input.forceActiveFocus()
        }
    }

    onFocusChanged: {
        if (activeFocus)
            input.forceActiveFocus()
    }
}
