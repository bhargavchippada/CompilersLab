
int fact(int n){
	if (n == 0) return 1;
	else return n*fact(n-1);
}

int f(int a, int b, float c){
	int x,y,z;

	printf("Value of a in f is :: ", a);
	printf("Value of b in f is :: ", b);
	printf("Value of c in f is :: ", c);

	y = 5;
	x = (a*b*b); 
	printf("Value of x in f is :: ", x);

	// y = x == y;
	// printf("Value of y in f is :: ", y);
	
	// y = x != y;
	// printf("Value of y in f is :: ", y);
	z = x > y;
	printf("Value of z in f is :: ", z);
	return x < y;
}

int main(){
	int x, y, z, w;
	int p[10][5], array[20];
	float t;
	int invcounts;
	//x = 1;
	//y = 2.0;
	//z = -1;
	//w = 5.5;
	// printf("flkgndljhpt");
	p[1][1] = 1.5;
	p[3][3] = 1.6;

	x = 4;

	// p[6][5] = 12;
	printf("heree");
	p[12][fact(2)] = fact(4);
	printf(" shoukd be 2:: ", p[12][2]);

	printf("fact(8) :: ", fact(fact(3) + fact(2)));




	if((1 || 2 || p[3][3]) && 0 && 5) printf("fljgnfljg");
	else ;

	for(x=0;x < 20; x++){
		if (x < 10)
			array[x] = x;
		else array[x] = 20 - x;
		printf("array[x] :: ", x, " : " , array[x]);

	}
		

	invcounts = 0;
	
	for(x = 0; x < 20; x++){
		for(y = 0; y < x; y++){
			if (array[y] > array[x]){
				invcounts = invcounts + 1;
			}
			else ;
		}
	}
	
	printf("invcounts :: " , invcounts);

	x = 1;
	y = 2;
	z = 5;
	t = 8;

	x = y*f(1,1,1)*z;
	printf("Value of x is :: ", x);

	x = x++;

    printf("Value of x++ is :: ", x++ + x++);
    printf("Value of p33 is :: ", p[3][3]++ + p[3][3]++);

	if (x || 0)
		z = 3;
	else z = 4;

	while(z > 0){
		z = z-1;
		printf("Value of z in loop is :: ", z);
	}

	z = 0;
	for (1; z < 5; 1){
		z = z + 1;
		y = 0;
		while(y < z){
			y = y+1;
			printf("Value of y in while for loop is :: ", y);
		}
		printf("Value of z in loop is :: ", z);
	}

	// z = 2;
	printf("Value of x is :: ", x);
	printf("Value of y is :: ", y);
	printf("Value of p2,3 is :: ", p[2][3]);
	printf("Value of p0,3 is :: ", p[0][3]);
	printf("Value of p4,3 is :: ", p[4][3]);
	printf("Value of z is :: ", z);
	// printf("Value of p2,3 is :: ", p[2][3]);
}
