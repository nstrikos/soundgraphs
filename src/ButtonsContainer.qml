import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3

Rectangle {
    id: buttonsContainer

    property alias test: buttonsColumn.test
    property alias test2: buttonsColumn.test2
    property alias test3: buttonsColumn.test3

    color: Qt.lighter("grey")
    width: 200
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
    }

    ButtonsColumn {
        id: buttonsColumn
    }
}
