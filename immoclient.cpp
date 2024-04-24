#include "immoclient.h"
#include <grpcpp/grpcpp.h>
#include "immo.grpc.pb.h"
#include <iostream>

ImmoClient::ImmoClient(QObject *parent): QObject(parent){}

QString ImmoClient::discoverNode(const QString& name, const QString& address)
{
	// Set up gRPC channel
	std::shared_ptr<grpc::Channel> channel = grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials());
	immo::ImmoService::Stub stub(channel);
	
	// Prepare gRPC request
	immo::NodeRequest request;
	request.set_name(name.toStdString());
	request.set_address(address.toStdString());

	// Call gRPC method
	grpc::ClientContext context;
	immo::NodeResponse response;
	grpc::Status status = stub.DiscoverNode(&context, request, &response);


	if (status.ok()) {
		// Process response and return
		return QString::fromStdString("Response: " + response.name());
	}
	else {
		// Handle error
		return QString::fromStdString("Error: " + status.error_message());
	}
}