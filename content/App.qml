// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5
import Immortals_GUI

Window {
    id: window
    width: homeScreen.width
    height: homeScreen.height
    visible: true
    title: "Immortals_GUI"

    Screen01 {
        id: homeScreen
    }

    Screen02 {
        id: autoScreen
        visible: false
    }

    ImmoPanel {
        id: panel
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

