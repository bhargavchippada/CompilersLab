typedef struct rec{
    int  data;
    struct rec* next;
    
} rec;

void p ()
{
    rec x; rec *y;
    y = malloc(sizeof(int));
    x.next = y;
}
