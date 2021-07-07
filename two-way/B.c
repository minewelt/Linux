//server B
//TCP
//ip:127.0.0.1
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
    int fifo_fd; //fifo id
    char buf[128] = {0};
    struct sockaddr_in addr = {0};
    fifo_fd = open("./myfifo",O_WRONLY,0777);
    if(-1==fifo_fd){
        printf("open myfifo error\n");
        return -3;
    }
    fd = socket(PF_INET,SOCK_STREAM,0);
    if(-1==fd){
        printf("socket error\n");
        return -1;
    }
    addr.sin_family = PF_INET;
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    addr.sin_port = htons(8888);
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
        printf("not access whileB");
        read(rw_fd,buf,128);
        printf("A: %s\n",buf);
        write(fifo_fd,buf,strlen(buf));
        for(int i=0;i<128;i++){
            buf[i] = 0;
        }
    }
    return 0;
}
