import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts
import Immortals_GUI

Popup {
    id: nodePopup
    property bool edit: false
    property int nodeID: -1
    property alias nodeName: nodeName.text
    property alias nodeClientID: nodeClientID.text

    contentItem: ColumnLayout {
        anchors.centerIn: parent
        spacing: 15
        
        TextField {id: nodeName; placeholderText: qsTr("Node Name"); Layout.topMargin: 15; Layout.leftMargin: 15}
        TextField {id: nodeClientID; placeholderText: qsTr("Client ID"); Layout.leftMargin: 15}
        Button {
            text: "Submit"
            Layout.alignment: Qt.AlignCenter
            onClicked: {
                if (edit) {
                    var success = nodeModel.updateNode(nodeID, selectedAgentID, nodeName.text);

                    if (success) {
                        console.log("Node Updated successfully!"); nodePopup.close();
                    } else {
                        console.error("Failed to Update Node."); nodePopup.close();
                    }
                } else {
                    var success = nodeModel.insertNode(nodeName.text, selectedAgentID, nodeClientID.text);

                    if (success) {
                        console.log("Node Added successfully!"); nodePopup.close();
                    } else {
                        console.error("Failed to Add Node."); nodePopup.close();
                    }

                }
            }
        }
        Item { Layout.fillHeight: true }
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 200
        color: Constants.backgroundColor
        radius: 15
        border.color: "#444"
        border.width: 5
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
    }

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

}
