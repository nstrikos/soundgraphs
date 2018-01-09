import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Column {
    id: buttonsColumn
    width: parent.width
    spacing: 5

    property alias test: parametersButton
    property alias test2: showGraphButton
    property alias test3: showTableButton
    
    ParametersButton {
        id: parametersButton
    }
    
    ShowGraphButton {
        id: showGraphButton
    }
    
    ShowTableButton {
        id: showTableButton
    }
}
