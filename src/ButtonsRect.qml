import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Rectangle {
    id: buttonsRect

    property alias parametersButton: parametersButton

    width: 200
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    color: "lightgray"
    Column {
        anchors.fill: parent
        spacing: 5
        ParametersButton {
            id: parametersButton
        }
        
        GraphButton {
            id: graphButton
        }
        
        Rect2Button {
            id: rect2Button
        }
        
        TableButton {
            id: tableButton
        }
    }
    Component.onCompleted: {
        parametersButton.forceActiveFocus()
    }
}
