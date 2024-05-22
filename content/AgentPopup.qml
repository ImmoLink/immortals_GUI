import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts
import Immortals_GUI

Popup {
    id: agentPopup

    property alias agentId: addressbox.agentId
    property alias agentHost: addressbox.agentHost
    property alias agentLabel: generalbox.agentLabel
    property alias agentTags: generalbox.agentTags

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 200
        color: Constants.backgroundColor
        radius: 15
        border.color: "#444"
        border.width: 5
    }

    contentItem:
        ColumnLayout {

        Addressbox {
            id: addressbox
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 120
            Layout.preferredWidth: 300
        }

        Generalbox {
            id: generalbox
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 180
            Layout.preferredWidth: 300
        }

        Grpcbox {
            id: grpcbox
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: 230
            Layout.preferredWidth: 300
        }

        Button {
            text: "Submit"
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 10
            onClicked: { 
                if (addressbox.agentId) { 
                    var success = agentModel.updateAgent(addressbox.agentId, addressbox.agentHost, generalbox.agentLabel, generalbox.agentTags, 1234, "newuser", "newpassword");
                    if (success) {
                        console.log("Agent updated successfully!");
                    } else {
                        console.error("Failed to update agent.");
                    }
                }else {
                    var success = agentModel.insertAgent(addressbox.agentHost, generalbox.agentLabel, generalbox.agentTags, 1234, "newuser", "newpassword");
                    if (success) {
                        console.log("Agent added successfully!");
                    } else {
                        console.error("Failed to add agent.");
                    }
                }
                agentPopup.close()
            }
        }
    }
    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0 }
    }
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
}
