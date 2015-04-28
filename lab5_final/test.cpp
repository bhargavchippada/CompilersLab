int f(int a, int b, float c){
	int x,y;

	printf("Value of a in f is :: ", a);
	printf("Value of b in f is :: ", b);
	printf("Value of c in f is :: ", c);

	y = 5;
	x = (a*b*b); 
	// y = x <= y;
	printf("Value of x in f is :: ", x);
	// printf("Value of y in f is :: ", y);
	// return x > y;
}

int main()
{
	int x, y, z, w;
	int p[4][5];
	float t;
	//x = 1;
	//y = 2.0;
	//z = -1;
	//w = 5.5;

	p[1][1] = 1.5;
	p[3][3] = 1.6;

	x = 1;
	y = 2;
	z = 5;
	t = 8;

	x = f(x, t, 6);

	p[1+1][2+1] = p[1+2][x+y]*x + y*y + z*z;

	printf("Value of y is :: ", y);

	p[0*(2*p[1][1]+3*p[1][1])][x+y] = ((p[1+1][x+y]*p[p[1][p[1][1]] + 2*p[1][1]][x+y])*(p[1+1][x+y]*p[1+1][x+y]))*p[1+1][x+y]*p[1+1][x+y];

	y = 4;

	printf("Value of y is :: ", y);

	z = 867.4;

	x = y - z;
	printf("Value of y is :: ", y);

	// x = !y;

	// x = y == z;	

	// x = y < z;
	// x = y > z;
	// x = y >= z;
	// x = y <= z;
	// x = y != z;

	// x = y + z;
	// x = y * z;
	// x = y / z;]

	x = p[3][3];


	x = (x<=y);
	printf("Value of x is :: ", x);
	printf("Value of y is :: ", y);
	printf("Value of p2,3 is :: ", p[2][3]);
	printf("Value of p0,3 is :: ", p[0][3]);
	printf("Value of p4,3 is :: ", p[4][3]);
	printf("Value of z is :: ", z);
	// printf("Value of p2,3 is :: ", p[2][3]);

	/*
	printf("fgkrfbgjkfg", 34);

	x = !p[1][1];


	p[2][3] = w;//p[x*w+z*(x+y+2)+x*y*z*w][x*w+z*(x+y+2)+x*y*z*w];
	*/
}
