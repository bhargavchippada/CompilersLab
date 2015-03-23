#include<malloc.h>
typedef struct rec{
    int  data;
    struct rec* next;
    
} rec;

rec p (int z)
{
    rec x; rec *y;
    y = malloc(sizeof(int));
    x.data = z;
    x.next = y;
    return x;
}


int main ()
{
  p(5);
}
