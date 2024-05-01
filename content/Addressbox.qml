import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

Rectangle {
    id: addressbox
    color: "#ffffff"
    radius: 15

    ToolBar {
        id: toolBar
        width: parent.width
        Text {
            text: qsTr("Address")
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: 15
        }
    }

    ColumnLayout {
        anchors.top: toolBar.bottom
        spacing: 15
        TextField {id: hostname; placeholderText: qsTr("Host/IP"); Layout.topMargin: 15; Layout.leftMargin: 15}
    }
}
