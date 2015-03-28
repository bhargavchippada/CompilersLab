#include <stdio.h>
#include <iostream>

using namespace std;

int swap(int x){
	return x*2;
}

int swap(float x){
	return x*5;
}

main(){
	printf("%d\n",swap(2.4));
}
