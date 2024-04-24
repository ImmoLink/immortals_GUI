#include <client.h>
#include <iostream>

// Method implementations for the ImmoClient class
ImmoClient::ImmoClient(std::shared_ptr<Channel> channel) : stub_(ImmoService::NewStub(channel)) {}

std::string ImmoClient::DiscoverNode(std::string name, std::string address) {
    NodeRequest request;
    request.set_name(name);
    request.set_address(address);
    NodeResponse response;
    ClientContext context;
    Status status = stub_->DiscoverNode(&context, request, &response);
    if (status.ok()) {
        return response.name();
    }
    else {
        std::cerr << "Error fetching node list: " << status.error_message() << std::endl;
        return "RPC Failed";
    }
}


void RunClient() {
    std::string target_address("localhost:50051");
    ImmoClient client(grpc::CreateChannel(target_address, grpc::InsecureChannelCredentials()));
    std::string response;
    std::string name = "reza";
    std::string address = "2e3e3";
    response = client.DiscoverNode(name, address);
    std::cout << "Response: " << response << std::endl;
}