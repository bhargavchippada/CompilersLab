#include<stdio.h>


h(int (* p)())
{
    int x;
    x = (*p)();
    
}

f()
{
    int r = 1;
    
    int g()
    {
        printf("%d\n", r);
    }
    
    h(&g);
    
}

main ()
{
    f();
}











