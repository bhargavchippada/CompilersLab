#include<stdio.h>

void f()
{
    printf("%d  %d  %d\n", 1,2,3);
}

void g()
{
    printf("%d  %d  %d  %d  %d\n", 1,2,3,4,5);
}


main ()
{
    int x,y;
    ((x>y)?  *f: *g)();
}











