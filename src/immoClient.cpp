#include "immoclient.h"
#include <grpcpp/grpcpp.h>
#include "immo.grpc.pb.h"
#include <iostream>

ImmoClient::ImmoClient(QObject* parent) : QObject(parent) {
	// Set up gRPC channel
	channel = grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials());
	stub = immo::ImmoService::NewStub(channel);
}

void ImmoClient::setChannel(std::shared_ptr<grpc::Channel>& newChannel) {
	channel = newChannel;
	stub = immo::ImmoService::NewStub(channel);
}

QString ImmoClient::discoverNode(const QString& name, const QString& address)
{
	// Prepare gRPC request
	immo::NodeRequest request;
	request.set_name(name.toStdString());
	request.set_address(address.toStdString());

	// Call gRPC method
	grpc::ClientContext context;
	immo::NodeResponse response;
	grpc::Status status = stub->DiscoverNode(&context, request, &response);

	if (status.ok()) {
		// Process response and return
		return QString::fromStdString("Response: " + response.SerializeAsString());
	}
	else {
		// Handle error
		return QString::fromStdString("Error: " + status.error_message());
	}
}