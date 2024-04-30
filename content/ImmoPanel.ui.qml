import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Shapes

Shape {
    id: panel
    ShapePath {
        strokeWidth: 4
        strokeColor: "blue"
        startX: 0; startY: 130
        PathLine { relativeX: parent.width * 0.05}
        PathLine { relativeX: parent.width * .40}
        PathLine { relativeX: parent.width * 0.05 ; y:  130}
    }
    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: panel.width * 0.2
        Button {
            id: button1
            text: qsTr("Home")
        } 
        Button {
            id: button2
            text: qsTr("Automation")
        } 
        Button {
            id: button3
            text: qsTr("Settings")
        } 
    }
}
