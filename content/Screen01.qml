import QtQuick 6.5
import QtQuick.Controls 6.5
import Immortals_GUI
import QtQuick.Studio.Components

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    Flickable {
        id: flickable
        x: 148
        y: 169
        width: 1100
        height: 320
        flickableDirection: Flickable.HorizontalFlick
        boundsBehavior: Flickable.DragOverBounds
        contentWidth: gridView.width
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        GridView {
            id: gridView
            width: rectangle.width * 0.8
            height: 300
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }
            }
            delegate: Item {
                x: 5
                height: 50
                Column {
                    spacing: 5
                    Rectangle {
                        width: 300
                        height: 300
                        color: colorCode
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        x: 5
                        text: name
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
            cellWidth: 300
            cellHeight: 300
        }

    }


}
