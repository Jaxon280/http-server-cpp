#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <iostream>

int main()
{
    int host_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (host_fd < 0)
    {
        std::cerr << "[ERROR] Failed to create socket.";
        return -1;
    }
    std::cout << "Socket is created." << std::endl;

    sockaddr_in host_sa;
    host_sa.sin_family = AF_INET;
    host_sa.sin_port = htons(2850); // hard coding
    host_sa.sin_addr.s_addr = INADDR_ANY;

    if (bind(host_fd, (struct sockaddr *)&host_sa, sizeof(host_sa)) < 0)
    {
        std::cerr << "[ERROR] Failed to bind address to socket." << std::endl;
        return -1;
    }
    std::cout << "Bind socket." << std::endl;

    if (listen(host_fd, SOMAXCONN) < 0)
    {
        std::cerr << "[ERROR] Failed to listen." << std::endl;
        return -1;
    }
    std::cout << "Start listening connection..." << std::endl;

    sockaddr_in remote_sa;
    socklen_t size_remote_sa = sizeof(remote_sa);
    int remote_fd = accept(host_fd, (sockaddr *)&remote_sa, &size_remote_sa);
    if (remote_fd < 0)
    {
        std::cerr << "[ERROR] Failed to accept client's connection." << std::endl;
        return -1;
    }
    std::cout << "Accept client's connection" << std::endl;

    char msg_buf[4096];
    while (true)
    {
        int bytes = recv(remote_fd, &msg_buf, sizeof(msg_buf), 0);
        if (bytes == 0)
        {
            std::cout << "[INFO] Client is disconnected.\n"
                      << std::endl;
            break;
        }
        else if (bytes < 0)
        {
            std::cerr << "[ERROR] Something went wrong while receiving data!.\n"
                      << std::endl;
            break;
        }
        else
        {
            std::cout << "Client sent messages:" << std::string(msg_buf, 0, bytes) << std::endl;
            if (send(remote_fd, &msg_buf, bytes, 0) < 0)
            {
                std::cerr << "[ERROR] Message cannnot be send" << std::endl;
                break;
            }
        }
    }
}
