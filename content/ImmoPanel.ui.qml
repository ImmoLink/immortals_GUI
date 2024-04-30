import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Shapes

Shape {
    id: shape
    width: 960
    height: 120
    ShapePath {
        strokeWidth: 4
        fillColor: "grey"
        strokeColor: "#00abff"
        startX: 0; startY: 120
        PathLine { x: 50; y: 0}
        PathLine { x: 910; y: 0}
        PathLine { x: 960; y: 120}
    }
    Row {
        spacing: parent.width * 0.2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Button {
            id: homeButton
            text: qsTr("Home")

            Connections {
                target: homeButton
                onClicked: {
                    homeScreen.visible = true
                    autoScreen.visible = false
                }
            }
        }
        Button {
            id: automationButton
            text: qsTr("Automation")

            Connections {
                target: automationButton
                onClicked: {
                    homeScreen.visible = false
                    autoScreen.visible = true
                }
            }
        }
        Button {
            id: settingsButton
            text: qsTr("Settings")

            Connections {
                target: settingsButton
                onClicked: {
                    homeScreen.visible = false
                    autoScreen.visible = false
                }
            }
        }
    }
}
