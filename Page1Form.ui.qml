import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    title: qsTr("Nodes")

    Label {
        text: qsTr("You are on Nodes Page")
        anchors.centerIn: parent
    }

    Row {
        id: row
        x: 200
        y: 0
        width: 200
        height: 400
    }
}
