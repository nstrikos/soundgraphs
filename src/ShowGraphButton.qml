import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Button {
    id: showGraphButton
    width: parent.width
    height: 50
    onClicked: {
        if (!firstRunning) {
            firstRunning = true
            graphSignal()
        }
        canvas.visible = true
        canvas.forceActiveFocus()
        controlsContainer.visible = false
        tableView.visible = false
        showTableButton.nextTab = 1
    }
    text: "Show graph"
}
