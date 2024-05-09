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
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.DragOverBounds
        contentWidth: nodeListView.width
        anchors.horizontalCenter: parent.horizontalCenter

        clip: true

        ListView {
            id: nodeListView
            width: contentWidth
            height: 300
            orientation: ListView.Horizontal
            model: nodeModel

            delegate: ItemDelegate {
                id: control
                height: 300
                width: 300

                background: Rectangle {
                    width: 300
                    height: 300
                    radius: 15
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    color: nodeListView.currentIndex == index ? "lightblue": control.down ? "#dddedf" : control.hovered ? Constants.hoverColor : "#eeeeee"
                }

                contentItem: Text {
                    anchors.centerIn: parent
                    text: name !== undefined ? name : "Unknown Host"
                }

                Button {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    flat: true
                    icon.source: "icons/menu.png"
                    width: 64
                    onClicked: nodeMenu.popup()
                }

                Menu {
                    id: nodeMenu
                    MenuItem { text: "Select"}
                    MenuItem { text: "Edit"; onClicked: {agentPopup.open(); fillFieldsWithData();}}
                    MenuItem { text: "Delete"; onClicked: nodeModel.deleteNode(id, selectedAgentID)}
                }
            }
        }
        
        Button {
            anchors.left: nodeListView.right
            visible: selectedAgentID !== -1
            height: 300
            width: 300
            text: qsTr("Add Node")
            onClicked: {
                agentPopup.open();
                agentPopup.agentId = null;
                agentPopup.agentHost = null;
                agentPopup.agentLabel = null; 
                agentPopup.agentTags = null;
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.background.color = Constants.hoverColor;
                    parent.background.opacity = Constants.hoverOpacity;
                }

                onExited: {
                    parent.background.color = "white";
                }
            }

            background: Rectangle {
                width: 300
                height: 300
                color: "white"
                radius: 15
                opacity: 0.6
                border.color: "black"
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