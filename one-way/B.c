#include<sys/socket.h>
#include<sys/types.h>
#include<stdio.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<string.h>
#include<sys/fcntl.h>
int main(){
    int fd;
    int ret;
    int rw_fd;
    int buf[1] = {0};
    struct sockaddr_in addr = {0};
    
    fd = socket(PF_INET,SOCK_STREAM,0);
    if(-1==fd){
        printf("socket error\n");
        return -1;
    }
    addr.sin_family = PF_INET;
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    addr.sin_port = htons(1234);
    ret = bind(fd,(struct sockaddr *)&addr,sizeof(struct sockaddr));
    if(-1==ret){
        printf("bind error\n");
        return -2;
    }
    listen(fd,20);
    printf("accept before\n");
    rw_fd = accept(fd,NULL,NULL);
    printf("accept after\n");

    while(1){
        read(rw_fd,buf,1);
        printf("A: %d\n",buf[0]);
        
        buf[0] = 0;
        
    }
    return 0;
}