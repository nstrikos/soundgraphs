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
        rect1.visible = false
        rect2.visible = false
        rect3.visible = true
        input5.forceActiveFocus()
        graphRect.visible = false
    }
}

//Button {
//    id: tableButton
//    width: parent.width
//    text: qsTr("Table")
//    KeyNavigation.tab: buttonNextTab()
//    onClicked: {
//        rect1.visible = false
//        rect2.visible = false
//        rect3.visible = true
//        input5.forceActiveFocus()
//        graphRect.visible = false
//    }
//    onActiveFocusChanged: {
//        if (activeFocus)
//            androidClient.speak(qsTr("Table button"))
//    }
//}
