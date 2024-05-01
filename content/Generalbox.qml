import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts

Rectangle {
    id: generalbox
    color: "#ffffff"
    radius: 25

    ToolBar {
        id: toolBar
        width: parent.width
        Text {
            text: qsTr("General")
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: 15
        }
    }

    ColumnLayout {
        anchors.top: toolBar.bottom
        spacing: 15
        TextField {id: labelField; placeholderText: qsTr("Label"); Layout.topMargin: 15; Layout.leftMargin: 15}
        TextField {id: tagsField; placeholderText: qsTr("Tags"); Layout.leftMargin: 15}
    }
}
