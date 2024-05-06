import QtQuick 6.5
import QtQuick.Layouts
import QtQuick.Controls 6.5
import Immortals_GUI
import com.example 1.0

Rectangle {
    width: 350
    height: 700
    anchors.leftMargin: 30

    AgentModel {
        id: agentModel // This assigns an id to the instance, allowing you to refer to it elsewhere in the QML file
    }

    ToolBar {
        id: toolBar
        width: parent.width

        Text {
            id: text1
            text: qsTr("Agents")
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: 15
        }

        Button {
            id: button
            width: 64
            height: parent.height
            anchors.right: parent.right
            icon.source: "icons/plus.png"
            onClicked: {
                popup.open();
                addressbox.agentId = null;
                addressbox.agentHost = null;
                generalbox.label = null; 
                generalbox.tags = null;
            }
        }
    }

    Popup {
        id: popup
        topInset: 10
        leftInset: 10
        rightInset: 10
        bottomInset: 10
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        modal: true
        focus: true

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
                            var success = agentModel.updateAgent(addressbox.agentId, addressbox.agentHost, generalbox.label, generalbox.tags, 1234, "newuser", "newpassword");
                            if (success) {
                                console.log("Agent updated successfully!");
                            } else {
                                console.error("Failed to update agent.");
                            }
                        }else {
                            var success = agentModel.insertAgent(addressbox.agentHost, generalbox.label, generalbox.tags, 1234, "newuser", "newpassword");
                            if (success) {
                                console.log("Agent added successfully!");
                            } else {
                                console.error("Failed to add agent.");
                            }
                        }
                        popup.close()
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

    ListView {
        id: listView
        anchors.top: toolBar.bottom
        width: parent.width
        height: 300
        model: agentModel // Use the model retrieved from c++

        delegate: Item {
            width: listView.width
            height: 50

            Rectangle {
                width: parent.width
                height: 50
                color: "lightblue"

                Text {
                    anchors.left: parent.left
                    leftPadding: 15
                    anchors.verticalCenter: parent.verticalCenter
                    text: label !== undefined ? label : "Unknown Host"
                }

                Button {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    flat: true
                    icon.source: "icons/menu.png"
                    width: 64
                    onClicked: agentMenu.popup()
                }
            }

            Menu {
                id: agentMenu
                MenuItem { text: "Select"}
                MenuItem { text: "Terminal"}
                MenuItem { text: "Edit"; onClicked: {popup.open(); fillFieldsWithData();}}
                MenuItem { text: "Delete"; onClicked: agentModel.deleteAgent(id)}
            }

            function fillFieldsWithData() {
                addressbox.agentId = id
                addressbox.agentHost = host
                generalbox.label = label
                generalbox.tags = tag
            }
        }
    }
}
