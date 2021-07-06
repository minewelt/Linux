#include<iostream>
#include<string.h>
using namespace std;

int findIndex(int r,int n,int s[]){
    int low = 0;
    int high = n-1;
    int k=0;
    while(s[k]!=r){
        k = (low+high)/2;
        if(s[k]>r){
            high = k-1;
        }
        else{
            low = k+1;
        }
    }
    return k;
}

int main(){
    int s[10] = {2,4,5,7,8,9,13,15,16,21};
    int n = sizeof(s)/4;
    int r;
    cout<<"input the number of you want to search: ";
    cin>>r;
    int index = findIndex(r,n,s);
    cout<<index<<endl;
    return 0;
}

