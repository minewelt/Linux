#include<stdio.h>
#include<unistd.h>
#include<string.h>
#include<sys/fcntl.h>
int main(){
    int fifo_fd;
    char buf[128] = {0};
    int dev_fd;
    fifo_fd = open("./myfifo",O_RDONLY,0777);
    if(-1==fifo_fd){
        printf("read myfifo error\n");
        return -1;
    }
    while(1){
        read(fifo_fd,buf,128);
        printf("fifo: %s\n",buf);
        if (buf[0] == '1'){
            dev_fd = open("./myad",O_RDWR,0777);

        }

        if (buf[0] == '2')
        {
            close(dev_fd);
        }
        
        
        for(int i=0;i<128;i++){
            buf[i] = 0;
        }
    }
    return 0;
}