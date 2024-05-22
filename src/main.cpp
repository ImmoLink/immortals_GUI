// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"

#include "initdb.h"
#include "agentModel.h"
#include "nodeModel.h"
#include "immoClient.h"

int main(int argc, char *argv[])
{
    set_qt_environment();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<AgentModel>("agent.model", 1, 0, "AgentModel");
    qmlRegisterType<NodeModel>("node.model", 1, 0, "NodeModel");
    qmlRegisterType<ImmoClient>("immo.client", 1, 0, "ImmoClient");

    InitDb db;
    // db.initDb();

    const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);
  
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
