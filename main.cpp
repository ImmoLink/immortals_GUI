#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlcontext.h>
//#include <client.h>
#include "immoclient.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<ImmoClient>("com.example", 1, 0, "ImmoClient");

    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/immortals-ui/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
