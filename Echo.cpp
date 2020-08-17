#include <sys/socket.h>
#include <arpa/inet.h>
#include <iostream>

int main()
{
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
    {
        std::cerr << "[ERROR] Failed to create socket.";
        return -1;
    }

    sockaddr_in sa;
    sa.sin_family = AF_INET;
    sa.sin_port = htons(2850); // hard coding
    sa.sin_addr.s_addr = INADDR_ANY;

    if (bind(sockfd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
    {
        std::cerr << "[ERROR] Failed to bind address to socket.";
        return -1;
    }
}
