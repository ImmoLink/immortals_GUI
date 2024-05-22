import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Studio.Components

import Immortals_GUI
import immo.client 1.0

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    ImmoClient {
        id: immoClient
    }

    Button {
        id: button
        text: qsTr("Press Me")
        anchors.centerIn: parent
        checkable: true

        Connections {
            target: button
            onClicked: {
                animation.start();
                runClient();
            }
        }
    }

    Text {
        id: label
        text: qsTr("Automation Page")
        font.family: Constants.font.family
        anchors.top: button.bottom
        anchors.topMargin: 45
        anchors.horizontalCenter: parent.horizontalCenter

        SequentialAnimation {
            id: animation

            ColorAnimation {
                id: colorAnimation1
                target: rectangle
                property: "color"
                to: "#2294c6"
                from: Constants.backgroundColor
            }

            ColorAnimation {
                id: colorAnimation2
                target: rectangle
                property: "color"
                to: Constants.backgroundColor
                from: "#2294c6"
            }
        }
    }

    function runClient() {
        var response = immoClient.discoverNode("reza", "14633310");
        console.log(response);
    }

    states: [
        State {
            name: "clicked"
            when: button.checked

            PropertyChanges {
                target: label
                text: qsTr("Button Checked")
            }
        }
    ]
}
