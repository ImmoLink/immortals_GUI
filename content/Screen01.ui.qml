import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Studio.Components
import Immortals_GUI

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: Constants.backgroundColor
    
    property alias selectedAgentID: nodePanel.selectedAgentID

    NodePanel {
        id: nodePanel
    }
}
