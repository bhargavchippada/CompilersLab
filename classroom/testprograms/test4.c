int g;

void p(int& x) 
{
    int a;
    x = x + 1;
    

}

/* void q(int& y)  */
/* { */
/*     int a; */
/*     a = y + 1; */

/* } */


main()
{
  p(g);
}
