#include<stdio.h>
#include<unistd.h>
#include<sys/stat.h>
int main(){
    int ret;
    ret = mkfifo("./myfifo",0777);
    if(-1==ret){
        printf("mkfifo error\n");
        return -1;
    }
    return 0;
}
