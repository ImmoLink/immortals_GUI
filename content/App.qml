// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5
import Immortals_GUI
import node.model 1.0

Window {
    id: window
    width: homeScreen.width
    height: homeScreen.height
    visible: true
    title: "Immortals_GUI"

    NodeModel {
        id: nodeModel
    }

    Screen01 {
        id: homeScreen
        visible: true
    }

    Screen02 {
        id: autoScreen
        visible: false
    }
    
    AgentPanel {
        id: agentPanel
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }

    ImmoPanel {
        id: immoPanel
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

