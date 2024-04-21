#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <grpcpp/grpcpp.h>
#include <immo.grpc.pb.h>
#include <iostream>

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using namespace immo;


int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/immortals-ui/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
