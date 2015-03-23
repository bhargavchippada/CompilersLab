#include<stdio.h>

typedef int (*funcptr) ();

h (int (*p) ())
{
  int x;
  x = (*p) ();
}

funcptr
f ()
{
  int r = 1;
  int g ()
  {
    printf ("%s%d\n", "I am here", r);
  }
  return (&g);
}

void
f1 ()
{
  int a = 1, b = 1, c = 1, d = 1, e = 1, f = 1;
}

main ()
{
  funcptr fp;
  fp = f ();
  f1 ();
  fp ();

}
