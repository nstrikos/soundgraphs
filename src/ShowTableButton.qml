import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Button {
    id: showTableButton
    property int nextTab: 0
    width: parent.width
    height: 50
    onClicked: {
        canvas.visible = false
        controlsContainer.visible = false
        tableView.visible = true
        tableView.forceActiveFocus()
        nextTab = 2
    }
    text: "Table"
    Accessible.onPressAction: {
        tableButton.clicked()
    }
    KeyNavigation.tab: controlsContainer.firstInputText
    onNextTabChanged: {
        console.log(nextTab)
        if (nextTab == 0)
            KeyNavigation.tab = controlsContainer.firstInputText
        else if (nextTab == 1)
            KeyNavigation.tab = focusScope
        else if (nextTab == 2) {
            KeyNavigation.tab = tableView
        }
    }
    
}
