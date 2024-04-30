// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.5
import Immortals_GUI

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "Immortals_GUI"


    Screen01 {
        id: mainScreen
    }

    ImmoPanel {
        id: panel
        width: parent.width * 0.5
        height: parent.height * 0.12
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

