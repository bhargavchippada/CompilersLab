#include <stdio.h>

extern void swap();

int buf [2] = {23, 56};

int main(){
	swap();
	printf("buf[0] = %d buf[1] = %d\n",buf[0],buf[1]);
	return 0;
}