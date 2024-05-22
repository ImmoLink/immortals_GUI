import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Studio.Components
import Immortals_GUI

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
            id: nodeMenuButton
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
            MenuItem { text: "Edit"; onClicked: {nodeEditPopup.open(); fillFieldsWithData();}}
            MenuItem { text: "Delete"; onClicked: nodeModel.deleteNode(id, selectedAgentID)}
        }

        NodePopup {
            id: nodeEditPopup
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

        function fillFieldsWithData() {
            nodeEditPopup.edit = true
            nodeEditPopup.nodeID = id
            nodeEditPopup.nodeName = name
            nodeEditPopup.nodeClientID = clientID
        }
    }
}