#ifndef IMMOCLIENT_H
#define IMMOCLIENT_H

#include <qobject.h>
#include <grpcpp/grpcpp.h>
#include "immo.grpc.pb.h"

class ImmoClient : public QObject
{
	Q_OBJECT
public:
	explicit ImmoClient(QObject* parent = nullptr);
	void setChannel(std::shared_ptr<grpc::Channel>& newChannel);
	Q_INVOKABLE QString discoverNode(const QString& name, const QString& address);

private:
	std::shared_ptr<grpc::Channel> channel;
	std::unique_ptr<immo::ImmoService::Stub> stub;
};

#endif