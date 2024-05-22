import QtQuick 6.5
import QtQuick.Controls 6.5

ListView {
    id: agentListView
    currentIndex: -1

    delegate: ItemDelegate {
        id: control
        width: agentListView.width
        height: 50
        highlighted: ListView.isCurrentItem

        onClicked: {
            console.log("label:", label , ", agentID:", id)
            agentListView.currentIndex = index
            nodeModel.loadNodes(id)
            homeScreen.selectedAgentID = id
        }

        background: Rectangle {
            id: rect
            width: parent.width
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: agentListView.currentIndex == index ? "lightblue": control.down ? "#dddedf" : control.hovered ? "lightsteelblue" : "#eeeeee"
        }

        contentItem: Text {
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

        Menu {
            id: agentMenu
            MenuItem { text: "Select"}
            MenuItem { text: "Terminal"}
            MenuItem { text: "Edit"; onClicked: {agentPopup.open(); fillFieldsWithData();}}
            MenuItem { text: "Delete"; onClicked: agentModel.deleteAgent(id)}
        }

        function fillFieldsWithData() {
            agentId = id
            agentHost = host
            agentLabel = label
            agentTags = tag
        }
    }
}
