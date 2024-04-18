#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <grpcpp/grpcpp.h>
#include <immo.grpc.pb.h>
#include <iostream>

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using namespace immo;
using namespace std;

class ImmoClient {
public:
    ImmoClient(std::shared_ptr<Channel> channel) : stub_(ImmoService::NewStub(channel)) { cout << "New Client"; }

private:
    std::unique_ptr<ImmoService::Stub> stub_;
};

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // Create gRPC channel
    std::shared_ptr<Channel> channel = grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials());

    // Create gRPC client
    ImmoClient client(channel);

    // Run event loop
    return app.exec();
}
