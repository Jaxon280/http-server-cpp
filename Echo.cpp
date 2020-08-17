#include <sys/socket.h>
#include <iostream>

int main()
{
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
    {
        std::cerr << "[ERROR] Failed to create socket." return -1
    }
}
