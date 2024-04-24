#ifndef IMMO_CLIENT_H
#define IMMO_CLIENT_H

#include <iostream>
#include <memory>
#include <string>
#include <grpcpp/grpcpp.h>
#include <immo.grpc.pb.h>

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using immo::NodeRequest;
using immo::NodeResponse;
using immo::ImmoService;

class ImmoClient {
public:
    ImmoClient(std::shared_ptr<Channel> channel);
    std::string DiscoverNode(std::string name, std::string address);
private:
    std::unique_ptr<ImmoService::Stub> stub_;
};

void RunClient();
#endif // IMMO_CLIENT_H