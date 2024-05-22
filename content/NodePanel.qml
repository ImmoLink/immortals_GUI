import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Studio.Components
import Immortals_GUI


Rectangle {
    id: nodePanel
    width: parent.width
    height: parent.height
    color: Constants.backgroundColor

    property int selectedAgentID: -1 // Property to store the selected agentID

    Flickable {
        id: flickable
        x: 148
        y: 169
        width: 1100
        height: 320
        anchors.horizontalCenter: parent.horizontalCenter
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.StopAtBounds // DragOverBounds
        contentWidth: nodeListView.width + addButton.width
        clip: true

        NodeListView { 
            id: nodeListView 
            property alias agentId: nodePanel.selectedAgentID
            property alias nodeName: nodePopup.nodeName
            property alias nodeClientID: nodePopup.nodeClientID
        }
 
        Rectangle {
            id: addButton
            anchors.left: nodeListView.right
            visible: selectedAgentID !== -1
            height: 300
            width: 300
            color: "white"
            radius: 15
            opacity: 0.6
            border.color: "black"

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onEntered: { parent.color = Constants.hoverColor; parent.opacity = Constants.hoverOpacity }
                onExited: { parent.color = "white" }
                onClicked: { 
                    console.log("Add Node Clicked...") ; 
                    nodePopup.open(); 
                    nodePopup.edit = false;
                    nodePopup.nodeName = null; 
                    nodePopup.nodeClientID = null
                }
            }

            NodePopup {
                id: nodePopup
                anchors.centerIn: parent
                topInset: 10
                leftInset: 10
                bottomInset: 10
                rightInset: 10
                width: 300
                height: 300
                modal: true
                focus: true
            }
        }
    }

    Item {
        id: placeholder
        anchors.fill: parent
        visible: selectedAgentID === -1
        Image {
            id: image
            width: 128
            source: "icons/agent.png"
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            id: text
            text: "Select agent..."
            anchors.top: image.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.pixelSize: 24
        }
    }
}