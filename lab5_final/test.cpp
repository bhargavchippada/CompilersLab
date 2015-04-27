
int main()
{
	int x, y, z, w;
	float p[4][5];
	x = 1;
	y = 2.0;
	z = -1;
	w = 5.5;
	
	p[2][3] = w;//p[x*w+z*(x+y+2)+x*y*z*w][x*w+z*(x+y+2)+x*y*z*w];
}
