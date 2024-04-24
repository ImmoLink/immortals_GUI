import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example 1.0


ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Immortals-UI"

    ImmoClient {
        id: immoClient
    }

    Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.pointSize: 42
        text: "Hello World!"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Button {
            text: "Run Client"
            onClicked: runClient()
        }

        TextArea {
            id: outputWidget
            width: parent.width
            height: parent.height - button.height
            readOnly: true
        }
    }

    function runClient() {
        var response = immoClient.discoverNode("reza", "14633310");
        outputWidget.text = response;
    }
}
