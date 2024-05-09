pragma Singleton
import QtQuick 6.5
import QtQuick.Studio.Application

QtObject {
    readonly property int width: 1920
    readonly property int height: 1080

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })

    readonly property color backgroundColor: "#EAEAEA"
    
    readonly property color hoverColor: "lightsteelblue"
    readonly property real hoverOpacity: 0.9
    readonly property color pressedColor: "blue"
    readonly property real pressedOpacity: 0.8
    readonly property color disabledColor: "gray"
    readonly property real disabledOpacity: 0.5

    property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../content/" + relativeFontDirectory)
    }
}
