void f()
{
	pushi(ebp); // Setting dynamic link
	move(esp,ebp); // Setting dynamic link
e:  loadi(ind(ebp), ebp); // restoring dynamic link
	popi(1); //pop stack
	return; //return
}

void main()
{
	move(4,eax);
	intTofloat(eax);
	loadf(ind(ebp,-8), eax);


	loadf(ind(ebp,-12), eax);


	loadf(ind(ebp,-8), eax);
	loadf(ind(ebp,-12), ebx);
	mulf(-1.0,ebx);
	addf(ebx,eax);
	loadf(ind(ebp,-4), eax);


	print_string("Value of x is :: ");
	loadf(ind(ebp,-4), eax);
	print_float(eax);
	print_char('\n');




	print_string("Value of y is :: ");
	loadf(ind(ebp,-8), eax);
	print_float(eax);
	print_char('\n');




	print_string("Value of z is :: ");
	loadf(ind(ebp,-12), eax);
	print_float(eax);
	print_char('\n');




	return; //return
}

