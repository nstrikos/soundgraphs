import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Button {
    id: parametersButton
    width: parent.width
    height: 50
    onClicked: {
        controlsContainer.visible = true
        canvas.visible = false
        tableView.visible = false
        controlsContainer.firstInputText.forceActiveFocus()
        showTableButton.nextTab = 0
    }
    text: "Parameters"
}
