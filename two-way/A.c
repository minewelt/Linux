#include<sys/socket.h>
#include<stdio.h>
#include<sys/types.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<string.h>
int main(){
    int fd;
    int ret;
    int rw_fd;
    char buf[128] = {0};
    struct sockaddr_in addr = {0};
    fd = socket(PF_INET,SOCK_STREAM,0);
    if(-1==fd){
        printf("socket error\n");
        return -1;
    }
    addr.sin_family = PF_INET;
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    addr.sin_port = htons(8888);
    ret = connect(fd,(struct sockaddr *)&addr,sizeof(struct sockaddr));
    if(-1==ret){
        printf("connect error\n");
        return -2;
    }
    

    while(1){
        printf("please input: \n");
        scanf("%s",buf);
        write(fd,buf,1); //send to B
        for(int i=0;i<128;i++){
            buf[i] = 0;
        }
    }
    return 0;
}
