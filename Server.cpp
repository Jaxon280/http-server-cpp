#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/event.h>
#include <iostream>

#define MAX_BUFFER_SIZE 4096

int main()
{
    int server_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (server_fd < 0)
    {
        std::cerr << "[ERROR] Failed to create socket.";
        return -1;
    }
    std::cout << "Socket is created." << std::endl;

    std::cout << "Which port do you use?" << '\n'
              << ">" << std::flush;
    std::string port;
    std::getline(std::cin, port);
    int port_i = std::stoi(port);

    sockaddr_in host_sa;
    host_sa.sin_family = AF_INET;
    host_sa.sin_port = htons(port_i); // hard coding
    host_sa.sin_addr.s_addr = INADDR_ANY;

    if (bind(server_fd, (struct sockaddr *)&host_sa, sizeof(host_sa)) < 0)
    {
        std::cerr << "[ERROR] Failed to bind address to socket." << std::endl;
        return -1;
    }
    std::cout << "Bind socket." << std::endl;

    if (listen(server_fd, SOMAXCONN) < 0)
    {
        std::cerr << "[ERROR] Failed to listen." << std::endl;
        return -1;
    }
    std::cout << "Start listening connection..." << std::endl;

    int kq = kqueue();
    if (kq < 0)
    {
        std::cerr << "[ERROR] Failed to create kqueue." << std::endl;
        return -1;
    }

    struct kevent kev;
    EV_SET(&kev, server_fd, EVFILT_READ, EV_ADD, 0, 0, NULL);
    int server_kv = kevent(kq, &kev, 1, NULL, 0, NULL);
    if (server_kv < 0)
    {
        std::cerr << "[ERROR] Failed to create server's kevent." << std::endl;
        return -1;
    }

    struct timespec waitspec;
    waitspec.tv_sec = 15;
    waitspec.tv_nsec = 0;

    while (true)
    {
        int new_event = kevent(kq, NULL, 0, &kev, 1, &waitspec);
        if (new_event < 0)
        {
            std::cerr << "[ERROR] Failed to get notification from kernel." << std::endl;
            break;
        }
        else if (new_event == 0)
        {
            continue;
        }
        else
        {
            if (kev.ident == server_fd)
            {
                sockaddr_in client_sa;
                socklen_t size_client_sa = sizeof(client_sa);
                int client_fd = accept(server_fd, (sockaddr *)&client_sa, &size_client_sa);
                if (client_fd < 0)
                {
                    std::cerr << "[ERROR] Failed to accept client's connection." << std::endl;
                    break;
                }
                std::cout << "Accept client's connection" << std::endl;

                int flags = fcntl(client_fd, F_GETFL, 0);
                if (flags < 0)
                {
                    std::cerr << "[ERROR] Failed to get flags of file descriptor." << std::endl;
                    break;
                }
                if (fcntl(client_fd, F_SETFL, flags | O_NONBLOCK) < 0)
                {
                    std::cerr << "[ERROR] Failed to set non-blocking flag." << std::endl;
                    break;
                }

                EV_SET(&kev, client_fd, EVFILT_READ, EV_ADD, 0, 0, NULL);
                int client_kv = kevent(kq, &kev, 1, NULL, 0, NULL);
                if (client_kv < 0)
                {
                    std::cerr << "[ERROR] Failed to add kevent to client's socket." << std::endl;
                }
            }
            else
            {
                char msg_buf[MAX_BUFFER_SIZE];
                std::memset(msg_buf, 0, MAX_BUFFER_SIZE);
                int bytes = recv(kev.ident, &msg_buf, MAX_BUFFER_SIZE, 0);
                if (bytes == 0)
                {
                    // File Descriptor が close() されるとカーネルによって自動でイベントは削除される.
                    std::cout << "Close socket by" << kev.ident << std::endl; // memo: 切断したクライアントの表示をソケットのディスクリプターではなくIPアドレスにしたい
                    if (close(kev.ident) < 0)
                    {
                        std::cerr << "[ERROR] Failed to close connection from client." << std::endl;
                    };
                    continue;
                }
                else if (bytes < 0)
                {
                    std::cerr << "Failed to receive message from" << kev.ident << std::endl;
                    break;
                }
                else
                {
                    std::cout << "Client sent messages:" << std::string(msg_buf, 0, bytes) << std::endl;
                }
            }
        }
    }

    if (close(server_fd) < 0)
    {
        std::cerr << "[ERROR] Failed to close socket.";
        return -1;
    }
    std::cout << "Close the socket..." << std::endl;
    return 0;
}
