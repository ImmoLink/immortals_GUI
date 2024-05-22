import QtQuick 6.5
import QtQuick.Layouts
import QtQuick.Controls 6.5
import Immortals_GUI
import agent.model 1.0

Rectangle {
    id: agentPanel
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
                agentPopup.open();
                agentPopup.agentId = null;
                agentPopup.agentHost = null;
                agentPopup.agentLabel = null; 
                agentPopup.agentTags = null;
            }
        }
    }

    AgentPopup {
        id: agentPopup
        anchors.centerIn: parent
        topInset: 10
        leftInset: 10
        bottomInset: 10
        rightInset: 10

        width: parent.width
        height: parent.height
        modal: true
        focus: true
    }

    AgentListView {
        id: agentListView
        anchors.top: toolBar.bottom
        height: contentHeight
        model: agentModel
        width: parent.width

        property alias agentId: agentPopup.agentId
        property alias agentHost: agentPopup.agentHost
        property alias agentLabel: agentPopup.agentLabel
        property alias agentTags: agentPopup.agentTags
    }
}
