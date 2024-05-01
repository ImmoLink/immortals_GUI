import QtQuick 6.5
import QtQuick.Layouts
import QtQuick.Controls 6.5
import Immortals_GUI

Rectangle {
    width: 350
    height: 700
    anchors.leftMargin: 30
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
            onClicked: popup.open()
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
                name: "Green"
                colorCode: "green"
            }
        }

        delegate: ItemDelegate {
                id: itemDelegate
                text: qsTr("Item Delegate")
        }
    }
}
