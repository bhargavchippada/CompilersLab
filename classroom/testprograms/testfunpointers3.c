#include<stdio.h>

typedef int (*funcptr)();

h(int (* p)())
{
    int x;
    x = (*p)();
}

funcptr f()
{
    int r = 2;
    int g()
    {
        printf("%s%d\n", "I am here ",  r);
    }
    return (&g);
}

main ()
{
    (f())();
}











