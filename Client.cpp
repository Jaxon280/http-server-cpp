#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <cstring>
#include <iostream>
#include <string>

int main()
{
    std::cout << "Start Client" << std::endl;
    int client_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (client_fd < 0)
    {
        std::cerr << "[ERROR] Failed to create socket" << std::endl;
        return -1;
    }

    std::string port;
    int port_i;
    while (true)
    {
        std::cout << "Which port do you use?" << '\n'
                  << ">" << std::flush;
        std::getline(std::cin, port);
        try
        {
            port_i = std::stoi(port);
        }
        catch (const std::invalid_argument &e)
        {
            std::cout << "Invalid port number. Please type integer format." << std::endl;
            continue;
        }
        break;
    }

    sockaddr_in server_sa;
    server_sa.sin_family = AF_INET;
    server_sa.sin_port = htons(port_i); // hard coding
    server_sa.sin_addr.s_addr = INADDR_ANY;
    if (connect(client_fd, (struct sockaddr *)&server_sa, sizeof(server_sa)) < 0)
    {
        std::cerr << "[ERROR] Failed to connect" << std::endl;
        return -1;
    }

    std::string data;

    while (true)
    {
        std::cout << "type message > " << std::flush;
        std::getline(std::cin, data);

        std::string const quit_command = "quit";
        if (data.size() < 0)
            continue;
        else if (data.compare(quit_command) == 0)
            break;

        if (send(client_fd, data.c_str(), data.size(), 0) < 0)
        {
            std::cerr << "[ERROR] Failed to send message.";
            return -1;
        }
    }

    if (close(client_fd) < 0)
    {
        std::cerr << "[ERROR] Failed to close socket.";
        return -1;
    }

    return 0;
}
