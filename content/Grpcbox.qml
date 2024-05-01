import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

Rectangle {
    id: grpcbox
    color: "#ffffff"
    radius: 15

    ToolBar {
        id: toolBar
        width: parent.width
        Text {
            text: qsTr("gRPC")
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: 15
        }
    }

    ColumnLayout {
        anchors.top: toolBar.bottom
        spacing: 15
        TextField {id: grpcport; placeholderText: qsTr("Port"); Layout.topMargin: 15; Layout.leftMargin: 15}
        TextField {id: grpcuser; placeholderText: qsTr("Username"); Layout.leftMargin: 15}
        TextField {id: grpcpass; placeholderText: qsTr("Password"); Layout.leftMargin: 15}

    }
}
